import express from 'express';
import { sumbitVideo } from './video_process.controller.js';

var videoProcessRouter = express.Router();

/**
 * @swagger
 * /video-process/submit:
 *   post:
 *     tags:
 *       - Video Process
 *     summary: Submit a YouTube video for audio download
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
 *       200:
 *         description: Audio downloaded successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 audio:
 *                   type: string
 *                   description: Local audio file path
 *       403:
 *         description: No URL provided
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *       500:
 *         description: Internal server error
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 error:
 *                   type: object
 */
videoProcessRouter.post('/submit', sumbitVideo);

/**
 * @swagger
 * /video-process/status/{id}:
 *   get:
 *     tags:
 *       - Video Process
 *     summary: Get submitted video processing status
 *     parameters:
 *       - name: id
 *         in: path
 *         required: true
 *         type: string
 *         example: 1234
 *         description: Processing job ID
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Video processing status
 */
videoProcessRouter.get('/status/:id', async (req, res) => { });

export default videoProcessRouter;
