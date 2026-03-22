import { Router } from 'express';
import { getSummaryById, summarizeVideo } from './videosummary.controller.js';

var summaryRoute = Router();

/**
 * @swagger
 * /summary:
 *   post:
 *     tags:
 *       - Summary
 *     summary: Generate a summary from transcript text
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - transcript
 *             properties:
 *               transcript:
 *                 type: string
 *                 description: Transcript text to summarize
 *     responses:
 *       200:
 *         description: Video summarized successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 summary:
 *                   type: object
 *       403:
 *         description: No transcript provided
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
summaryRoute.post('/', summarizeVideo);

/**
 * @swagger
 * /summary/{id}:
 *   get:
 *     tags:
 *       - Summary
 *     summary: Get saved summary by job ID
 *     parameters:
 *       - name: id
 *         in: path
 *         required: true
 *         type: string
 *         example: 1234
 *         description: Job ID
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Video summarized successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 summary:
 *                   type: object
 *       500:
 *         description: Internal server error
 */
summaryRoute.get('/:id', getSummaryById);
export default summaryRoute;
