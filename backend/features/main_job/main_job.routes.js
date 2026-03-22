import express from 'express';
import { createJob, getJobResult, getJobStatus, streamJobEvents, updateJob } from './main_job.controller.js';
import { hasActivePlan } from '../../middlewares/hasActivePlan.middleware.js';
import { withinQuota } from '../../middlewares/withinQuota.middleware.js';
import { requireAuth } from '../../utils/auth.guards.js';

const router = express.Router();

/**
 * @swagger
 * /jobs:
 *   post:
 *     tags:
 *       - Jobs
 *     summary: Create a YouTube processing job
 *     security:
 *       - Authorization: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - url
 *             properties:
 *               url:
 *                 type: string
 *                 description: YouTube video URL
 *     responses:
 *       202:
 *         description: Job accepted
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   type: object
 *       400:
 *         description: Missing or invalid URL
 *       500:
 *         description: Internal server error
 */
router.post('/', requireAuth, hasActivePlan, withinQuota, createJob);

/**
 * @swagger
 * /jobs/{jobId}:
 *   get:
 *     tags:
 *       - Jobs
 *     summary: Get job status
 *     security:
 *       - Authorization: []
 *     parameters:
 *       - name: jobId
 *         in: path
 *         required: true
 *         type: string
 *         description: Job ID
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Job status
 *       403:
 *         description: Forbidden
 *       404:
 *         description: Job not found
 *       500:
 *         description: Internal server error
 */
router.get('/:jobId', requireAuth, getJobStatus);

/**
 * @swagger
 * /jobs/{jobId}/events:
 *   get:
 *     tags:
 *       - Jobs
 *     summary: Stream job status events
 *     security:
 *       - Authorization: []
 *     parameters:
 *       - name: jobId
 *         in: path
 *         required: true
 *         type: string
 *         description: Job ID
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Server-sent event stream
 *         content:
 *           text/event-stream:
 *             schema:
 *               type: string
 */
router.get('/:jobId/events', requireAuth, streamJobEvents);

/**
 * @swagger
 * /jobs/{jobId}/result:
 *   get:
 *     tags:
 *       - Jobs
 *     summary: Get job result
 *     security:
 *       - Authorization: []
 *     parameters:
 *       - name: jobId
 *         in: path
 *         required: true
 *         type: string
 *         description: Job ID
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Completed job result
 *       202:
 *         description: Job still processing
 *       403:
 *         description: Forbidden
 *       404:
 *         description: Job not found
 *       500:
 *         description: Internal server error
 */
router.get('/:jobId/result', requireAuth, getJobResult);

/**
 * @swagger
 * /jobs/{jobId}/callback:
 *   post:
 *     tags:
 *       - Jobs
 *     summary: Worker callback to update job state
 *     parameters:
 *       - name: jobId
 *         in: path
 *         required: true
 *         type: string
 *         description: Job ID
 *         schema:
 *           type: string
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               status:
 *                 type: string
 *               progress:
 *                 type: string
 *               transcript:
 *                 type: string
 *               summary:
 *                 type: string
 *               transcript_url:
 *                 type: string
 *               summary_url:
 *                 type: string
 *               error_message:
 *                 type: string
 *     responses:
 *       200:
 *         description: Job updated
 *       400:
 *         description: No valid fields provided
 *       401:
 *         description: Invalid worker callback signature
 *       404:
 *         description: Job not found
 *       500:
 *         description: Internal server error
 */
router.post('/:jobId/callback', updateJob);

export default router;
