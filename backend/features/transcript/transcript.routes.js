
import { Router } from 'express';
import { transcriptFn } from './transcript.controller.js';

const transcriptRoute = Router();

/**
 * @swagger
 * /transcript:
 *   post:
 *     tags:
 *       - Transcript
 *     summary: Transcribe a local audio file
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - audio
 *             properties:
 *               audio:
 *                 type: string
 *                 description: Local audio file path
 *     responses:
 *       200:
 *         description: Audio transcribed successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 transcript:
 *                   type: string
 *       403:
 *         description: No audio provided
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
 */
transcriptRoute.post('/',transcriptFn );

export default transcriptRoute;
