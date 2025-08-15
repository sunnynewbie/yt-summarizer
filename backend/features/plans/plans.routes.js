import express from 'express';
import { addPlan, deletePlan, getPlans, getSinglePlan, updatePlan } from './plans.controller.js';

const planRoutes = express.Router()

/**
 * @swagger
 * /plans:
 *   get:
 *     tags:
 *       - Plan
 *     summary: Get all plans
 *     responses:
 *       200:
 *         description: Success
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   description: Success status
 *                 message:
 *                   type: string
 *                   description: Success message
 *                 data:
 *                   type: array
 *                   description: Array of plans
 */
planRoutes.get('/', getPlans);
/**
 * @swagger
 * /plans/{id}:
 *   get:
 *     tags:
 *       - Plan
 *     summary: Get single plan
 *     parameters:
 *       - name: id
 *         in: path
 *         required: true
 *         type: string
 *         example: 1234
 *         description: Plan ID
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Success
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   description: Success status
 *                 message:
 *                   type: string
 *                   description: Success message
 *                 data:
 *                   type: object
 *                   description: Single plan
 * 
 */
planRoutes.get('/:id', getSinglePlan);
/**
 * @swagger
 * /plans:
 *   post:
 *     tags:
 *       - Plan
 *     summary: Create a new plan
 *     requestBody:
 *       required: true
 *       description: Create a new plan
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - plan_name
 *               - video_limit
 *               - minute_limit
 *               - price
 *             properties:
 *               plan_name:
 *                 type: string
 *                 description: Plan name
 *               video_limit:
 *                 type: number
 *                 description: Video limit
 *               minute_limit:
 *                 type: number
 *                 description: Minute limit
 *               price:
 *                 type: number
 *                 description: Price
 *     responses:
 *       200:
 *         description: Success
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   description: Success status
 *                 message:
 *                   type: string
 *                   description: Success message
 *                 data:
 *                   type: object
 *                   description: Single plan
 * 
 */
planRoutes.post('/', addPlan);
/**
 * @swagger
 * /plans/{id}:
 *   patch:
 *     tags:
 *       - Plan
 *     summary: Update a plan
 *     parameters:
 *       - name: id
 *         in: path
 *         required: true
 *         type: string
 *         example: 1234
 *         description: Plan ID
 *         schema:
 *           type: string
 *     requestBody:
 *       required: true
 *       description: Update a plan
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - plan_name
 *               - video_limit
 *               - minute_limit
 *               - price
 *             properties:
 *               plan_name:
 *                 type: string
 *                 description: Plan name
 *               video_limit:
 *                 type: number
 *                 description: Video limit
 *               minute_limit:
 *                 type: number
 *                 description: Minute limit
 *               price:
 *                 type: number
 *                 description: Price
 *     responses:
 *       200:
 *         description: Success
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   description: Success status
 *                 message:
 *                   type: string
 *                   description: Success message
 *                 data:
 *                   type: object
 *                   description: Single plan
 * 
 */
planRoutes.patch('/:id', updatePlan);

/**
 * @swagger
 * /plans/{id}:
 *   delete:
 *     tags:
 *       - Plan
 *     summary: Delete a plan
 *     parameters:
 *       - name: id
 *         in: path
 *         required: true
 *         type: string
 *         example: 1234
 *         description: Plan ID
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Success
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   description: Success status
 *                 message:
 *                   type: string
 *                   description: Success message
 *                 data:
 *                   type: object
 *                   description: Single plan
 * 
*/
planRoutes.delete("/:id/", deletePlan);

export default planRoutes