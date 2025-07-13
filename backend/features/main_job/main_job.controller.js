
import { v4 as uuidv4 } from 'uuid';
import { jobStore } from './../../utils/job.store.js';
import { processYoutubeJob } from './../../utils/job.worker.js';
import jobs from '../../models/jobs.js';

// Create new job

export async function createJob(req, res) {
    const { url } = req.body;

    if (!url) {
        return res.status(400).json({ error: 'Missing YouTube URL' });
    }

    const jobId = uuidv4();
    var result = jobs.create({
        id: jobId,
        video_url: url,
        status: 'queued',
    })

    // 🧠 Call the background worker (async)
    processYoutubeJob(jobId, url); // No `await` to avoid blocking the API

    // 🔁 Return jobId so client can poll
    return res.status(202).json({ jobId, status: 'queued' });

}

// Get job status
export async function getJobStatus(req, res) {
    const job = jobStore.get(req.params.jobId);
    if (!job) return res.status(404).json({ error: 'Job not found' });

    return res.json({ jobId: req.params.jobId, status: job.status });
}

// Get job result
export async function getJobResult(req, res) {
    const job = jobStore.get(req.params.jobId);
    if (!job) return res.status(404).json({ error: 'Job not found' });

    if (job.status !== 'completed') {
        return res.status(202).json({ status: job.status });
    }

    return res.json({ success: true, transcript: job.result.transcript, summary: job.result.summary });
}
export function updateJob(req, res) {

}
