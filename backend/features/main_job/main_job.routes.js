import express from 'express';
import { jobStore } from '../../utils/job.store.js';
import { createJob } from './main_job.controller.js';
import { Jobs } from 'openai/resources/fine-tuning/jobs/jobs.mjs';
import jobs from '../../models/jobs.js';
import { hasActivePlan } from '../../middlewares/hasActivePlan.middleware.js';
import { withinQuota } from '../../middlewares/withinQuota.middleware.js';
const router = express.Router();


/**
 * @swagger
 * /start-summerize:
 *   post:
 *     tags:
 *       - Main Job
 *     summary: Create a new job
 *     requestBody:
 *       required: true
 *       description: Create a new job
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - url
 *             properties:
 *               url:
 *                 type: string
 *                   
 *     responses:
 *       202:
 *         description: Job created successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 jobId:   
 *                   type: string   
 *                   description: Job ID
 *                 status:
 *                   type: string
 *                   description: Job status
 *       400:
 *         description: Bad request
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:   
 *                   type: string   
 *                   description: Error message
 * 
 *
 *
 */
router.post('/', hasActivePlan, withinQuota, createJob);

/**
 * @swagger
 * /summary-job/{jobId}/events:
 *   get:
 *     tags:
 *       - Main Job
 *     summary: Get job events
 *     parameters:
 *       - name: jobId
 *         in: path
 *         required: true
 *         type: string
 *         example: 1234
 *         description: Job ID
 *         schema:
 *           type: string   
 * 
 *     responses:
 *       200:
 *         description: Job events
 *         content:
 *           text/event-stream:
 *             schema:
 *               type: string
 *               description: SSE data
 *       404:
 *         description: Job not found
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:   
 *                   type: string   
 *                   description: Error message
 * 
 */
router.get('/:jobId/events', async (req, res) => {
    const { jobId } = req.params;

    // ---------- 1.  Set SSE headers ----------
    res.setHeader('Content-Type', 'text/event-stream');
    res.setHeader('Cache-Control', 'no-cache');
    res.setHeader('Connection', 'keep-alive');
    res.flushHeaders();                          // send headers immediately

    // ---------- 2.  Send initial snapshot ----------
    const job = await jobs.findOne({ where: { id: jobId } });
    if (!job) {
        res.write(`event: error\ndata: ${JSON.stringify({ message: 'Job not found' })}\n\n`);
        return res.end();
    }
    res.write(`data: ${JSON.stringify({ status: job.toJSON().status, })}\n\n`);

    // ---------- 3.  Poll jobStore & push diffs ----------
    let lastIndex = job.log?.length || 0;
    const interval = setInterval(async () => {
        const j = await jobs.findOne({ where: { id: jobId } });
        if (!j) return;

        if (j.status === 'completed' || j.status === 'failed') {
            res.write(`event: status\ndata: ${JSON.stringify({ status: j.toJSON().status })}\n\n`);
            clearInterval(interval);
            res.end();              // close stream when done
        }
    }, 2000);
    const aliveInterval = setInterval(() => {
        res.write(':\n\n'); // comment-style keep-alive
    }, 15000); // every 15s                // every 2 s

    // ---------- 4.  Clean up on client disconnect ----------
    req.on('close', () => {
        clearInterval(interval)
        clearInterval(aliveInterval);
    });
});
// router.get('/:jobId/result', getJobResult);

export default router;
