import jobs from '../models/jobs.js';
import { submitJobToWorker } from './worker.client.js';

export async function processYoutubeJob(jobId, youtubeUrl) {
    try {
        await jobs.update(
            { status: 'dispatched', progress: 'Job submitted to worker' },
            { where: { id: jobId } }
        );

        await submitJobToWorker({ jobId, videoUrl: youtubeUrl });
    } catch (err) {
        await jobs.update(
            {
                status: 'failed',
                error_message: err.message,
                progress: 'Failed to submit job to worker',
            },
            { where: { id: jobId } }
        );
        console.error('Job dispatch failed:', err.message);
    }
}
