import express from 'express';
import axios from 'axios';
import crypto from 'crypto';
import './config/env.js';
import { env } from './config/env.js';

const app = express();
const workerPort = Number.parseInt(process.env.WORKER_PORT ?? '8000', 10);

app.use(express.json({ limit: '1mb' }));

function signPayload(timestamp, payload) {
    if (!env.workerCallbackSecret) {
        return '';
    }

    return crypto
        .createHmac('sha256', env.workerCallbackSecret)
        .update(`${timestamp}.${payload}`)
        .digest('hex');
}

async function sendCallback(callbackUrl, body) {
    const payload = JSON.stringify(body);
    const timestamp = Math.floor(Date.now() / 1000).toString();
    const headers = env.workerCallbackSecret
        ? {
            'x-worker-timestamp': timestamp,
            'x-worker-signature': signPayload(timestamp, payload),
        }
        : {};

    await axios.post(callbackUrl, body, {
        headers: {
            'Content-Type': 'application/json',
            ...headers,
        },
        timeout: 10000,
    });
}

app.get('/health', (req, res) => {
    res.status(200).json({ success: true, status: 'ok' });
});

app.post('/jobs', async (req, res) => {
    const { jobId, url, callbackUrl } = req.body;

    if (!jobId || !url || !callbackUrl) {
        return res.status(400).json({ error: 'jobId, url and callbackUrl are required' });
    }

    res.status(202).json({
        success: true,
        data: {
            jobId,
            status: 'accepted',
        },
    });

    setTimeout(() => {
        sendCallback(callbackUrl, {
            status: 'processing',
            progress: 'Worker accepted the job in local dev mode',
        }).catch((error) => {
            console.error('Mock worker callback error:', error.message);
        });
    }, 500);

    setTimeout(() => {
        sendCallback(callbackUrl, {
            status: 'completed',
            progress: 'Local mock worker completed the job',
            transcript_url: `local://transcripts/${jobId}`,
            summary_url: `local://summaries/${jobId}`,
        }).catch((error) => {
            console.error('Mock worker callback error:', error.message);
        });
    }, 1500);
});

app.listen(workerPort, () => {
    console.log(`Mock worker listening on port ${workerPort}`);
});
