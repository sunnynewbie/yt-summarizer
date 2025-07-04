// File: backend/workers/job.worker.js
import jobs from '../models/jobs.js';
import { jobStore } from './job.store.js';
import axios from 'axios';

const BASE_URL = 'http://localhost:5000'; // or process.env.BASE_URL if running on container

export async function processYoutubeJob(jobId, youtubeUrl) {
    try {
        jobStore.set(jobId, { status: 'downloading' });
        const downloadStatus = await jobs.update({ status: 'downloading', video_url: youtubeUrl }, { where: { id: jobId }, returning: true })

        const audioRes = await axios.post(`${BASE_URL}/video_process/submit`, { url: youtubeUrl });
        const audioPath = audioRes.data.audio;
        const transcribing = await jobs.update({ status: 'transcribing' }, { where: { id: jobId }, returning: true })

        const transRes = await axios.post(`${BASE_URL}/transcript`, { audio: audioPath });
        const transcript = transRes.data.transcript;
        const summarizing = await jobs.update({ status: 'summarizing', transcript: transcript }, { where: { id: jobId }, returning: true })

        const sumRes = await axios.post(`${BASE_URL}/summary`, { transcript: transcript });
        const summary = sumRes.data;

        const result = await jobs.update({ status: 'completed', summary: summary.summary.response }, { where: { id: jobId }, returning: true })

    } catch (err) {
        const result = await jobs.update({ status: 'failed', }, { where: { id: jobId }, returning: true })
        console.error('❌ Job failed:', err.message);
    }
}
