import { v4 as uuidv4 } from 'uuid';
import crypto from 'crypto';
import { processYoutubeJob } from './../../utils/job.worker.js';
import jobs from '../../models/jobs.js';
import { env } from '../../config/env.js';
import { setAuditContext } from '../../utils/audit.js';

const allowedYoutubeHosts = new Set([
    'youtube.com',
    'www.youtube.com',
    'm.youtube.com',
    'youtu.be',
]);

function canAccessJob(req, job) {
    return req.user?.role === 'admin' || job.user_id === req.user?.id;
}

function verifyWorkerSignature(req) {
    if (!env.workerCallbackSecret) {
        return true;
    }

    const timestamp = req.headers['x-worker-timestamp'];
    const signature = req.headers['x-worker-signature'];

    if (!timestamp || !signature) {
        return false;
    }

    const requestTimestamp = Number.parseInt(String(timestamp), 10);
    if (Number.isNaN(requestTimestamp)) {
        return false;
    }

    const now = Math.floor(Date.now() / 1000);
    if (Math.abs(now - requestTimestamp) > env.webhookToleranceSeconds) {
        return false;
    }

    const payload = req.rawBody || JSON.stringify(req.body);
    const expected = crypto
        .createHmac('sha256', env.workerCallbackSecret)
        .update(`${timestamp}.${payload}`)
        .digest('hex');

    const expectedBuffer = Buffer.from(expected, 'hex');
    const receivedBuffer = Buffer.from(String(signature), 'hex');

    if (expectedBuffer.length !== receivedBuffer.length) {
        return false;
    }

    return crypto.timingSafeEqual(expectedBuffer, receivedBuffer);
}

export async function createJob(req, res) {
    try {
        const { url } = req.body;

        if (!url) {
            return res.status(400).json({ error: 'Missing YouTube URL' });
        }

        let normalizedUrl;
        try {
            normalizedUrl = new URL(url);
        } catch (error) {
            return res.status(400).json({ error: 'Invalid URL' });
        }

        if (!allowedYoutubeHosts.has(normalizedUrl.hostname)) {
            return res.status(400).json({ error: 'Only YouTube URLs are supported' });
        }

        const jobId = uuidv4();
        await jobs.create({
            id: jobId,
            user_id: req.user.id,
            video_url: normalizedUrl.toString(),
            status: 'queued',
            progress: 'Job accepted by API',
        });

        processYoutubeJob(jobId, normalizedUrl.toString());

        setAuditContext(req, {
            action: 'jobs.create',
            featureArea: 'jobs',
            resourceType: 'job',
            resourceId: jobId,
            actorUserId: req.user.id,
            actorRole: req.user?.role,
            metadata: { job_status: 'queued', host: normalizedUrl.hostname },
        });
        return res.status(202).json({
            success: true,
            data: {
                jobId,
                status: 'queued',
            },
        });
    } catch (error) {
        console.error('Create job error:', error);
        return res.status(500).json({ error: 'Internal server error' });
    }
}

export async function getJobStatus(req, res) {
    try {
        const job = await jobs.findByPk(req.params.jobId);
        if (!job) return res.status(404).json({ error: 'Job not found' });
        if (!canAccessJob(req, job)) return res.status(403).json({ error: 'Forbidden' });

        setAuditContext(req, {
            action: 'jobs.status.read',
            featureArea: 'jobs',
            resourceType: 'job',
            resourceId: job.id,
            actorUserId: req.user.id,
            actorRole: req.user?.role,
            metadata: { job_status: job.status },
        });
        return res.status(200).json({
            success: true,
            data: {
                id: job.id,
                status: job.status,
                progress: job.progress,
                error_message: job.error_message,
                transcript_url: job.transcript_url,
                summary_url: job.summary_url,
                createdAt: job.createdAt,
                updatedAt: job.updatedAt,
            },
        });
    } catch (error) {
        console.error('Get job status error:', error);
        return res.status(500).json({ error: 'Internal server error' });
    }
}

export async function getJobResult(req, res) {
    try {
        const job = await jobs.findByPk(req.params.jobId);
        if (!job) return res.status(404).json({ error: 'Job not found' });
        if (!canAccessJob(req, job)) return res.status(403).json({ error: 'Forbidden' });

        if (job.status !== 'completed') {
            setAuditContext(req, {
                action: 'jobs.result.read',
                featureArea: 'jobs',
                resourceType: 'job',
                resourceId: job.id,
                actorUserId: req.user.id,
                actorRole: req.user?.role,
                metadata: { job_status: job.status, ready: false },
            });
            return res.status(202).json({
                success: true,
                data: { status: job.status },
            });
        }

        setAuditContext(req, {
            action: 'jobs.result.read',
            featureArea: 'jobs',
            resourceType: 'job',
            resourceId: job.id,
            actorUserId: req.user.id,
            actorRole: req.user?.role,
            metadata: { job_status: job.status, ready: true },
        });
        return res.status(200).json({
            success: true,
            data: {
                id: job.id,
                status: job.status,
                transcript: job.transcript,
                summary: job.summary,
                transcript_url: job.transcript_url,
                summary_url: job.summary_url,
            },
        });
    } catch (error) {
        console.error('Get job result error:', error);
        return res.status(500).json({ error: 'Internal server error' });
    }
}

export async function streamJobEvents(req, res) {
    const { jobId } = req.params;

    res.setHeader('Content-Type', 'text/event-stream');
    res.setHeader('Cache-Control', 'no-cache, no-transform');
    res.setHeader('Connection', 'keep-alive');
    res.flushHeaders();

    const sendEvent = (event, payload) => {
        res.write(`event: ${event}\n`);
        res.write(`data: ${JSON.stringify(payload)}\n\n`);
    };

    let interval;
    let keepAlive;

    try {
        const job = await jobs.findByPk(jobId);
        if (!job) {
            sendEvent('error', { message: 'Job not found' });
            return res.end();
        }
        if (!canAccessJob(req, job)) {
            sendEvent('error', { message: 'Forbidden' });
            return res.end();
        }

        setAuditContext(req, {
            action: 'jobs.events.stream',
            featureArea: 'jobs',
            resourceType: 'job',
            resourceId: job.id,
            actorUserId: req.user.id,
            actorRole: req.user?.role,
            metadata: { initial_status: job.status },
        });
        let lastSnapshot = JSON.stringify({
            status: job.status,
            progress: job.progress,
            error_message: job.error_message,
        });

        sendEvent('status', JSON.parse(lastSnapshot));

        interval = setInterval(async () => {
            try {
                const currentJob = await jobs.findByPk(jobId);
                if (!currentJob) {
                    sendEvent('error', { message: 'Job not found' });
                    clearInterval(interval);
                    clearInterval(keepAlive);
                    return res.end();
                }

                const nextSnapshot = JSON.stringify({
                    status: currentJob.status,
                    progress: currentJob.progress,
                    error_message: currentJob.error_message,
                });

                if (nextSnapshot !== lastSnapshot) {
                    lastSnapshot = nextSnapshot;
                    sendEvent('status', JSON.parse(nextSnapshot));
                }

                if (['completed', 'failed'].includes(currentJob.status)) {
                    clearInterval(interval);
                    clearInterval(keepAlive);
                    return res.end();
                }
            } catch (error) {
                sendEvent('error', { message: 'Failed to read job status' });
                clearInterval(interval);
                clearInterval(keepAlive);
                return res.end();
            }
        }, 2000);

        keepAlive = setInterval(() => {
            res.write(':\n\n');
        }, 15000);

        req.on('close', () => {
            clearInterval(interval);
            clearInterval(keepAlive);
        });
    } catch (error) {
        console.error('Stream job events error:', error);
        clearInterval(interval);
        clearInterval(keepAlive);
        sendEvent('error', { message: 'Internal server error' });
        return res.end();
    }
}

export async function updateJob(req, res) {
    try {
        if (!verifyWorkerSignature(req)) {
            return res.status(401).json({ error: 'Invalid worker callback signature' });
        }

        const job = await jobs.findByPk(req.params.jobId);
        if (!job) {
            return res.status(404).json({ error: 'Job not found' });
        }

        const allowedFields = ['status', 'progress', 'transcript', 'summary', 'transcript_url', 'summary_url', 'error_message'];
        const payload = Object.fromEntries(
            Object.entries(req.body).filter(([key, value]) => allowedFields.includes(key) && value !== undefined)
        );

        if (Object.keys(payload).length === 0) {
            return res.status(400).json({ error: 'No valid fields provided for update' });
        }

        await job.update(payload);
        setAuditContext(req, {
            action: 'jobs.callback.update',
            featureArea: 'jobs',
            resourceType: 'job',
            resourceId: job.id,
            metadata: { updated_fields: Object.keys(payload).sort(), status: payload.status || job.status },
        });
        return res.status(200).json({ success: true });
    } catch (error) {
        console.error('Update job error:', error);
        return res.status(500).json({ error: 'Internal server error' });
    }
}
