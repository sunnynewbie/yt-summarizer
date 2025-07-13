import express from 'express';
import { noActiveSubscription } from '../../middlewares/noActiveSubscription.middleware.js';
import { cancelSubscription, createSubscription, getUserSubscription, getUserSubscriptionHistory } from './subscriptions.controller.js';

const subsRoutes = express.Router();
/**
 * @swagger
 * /subscribe:
 *   post:
 *     tags:
 *       - Subscription
 *     summary: Subscribe to a plan
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               user_id:
 *                 type: string
 *                 description: User ID
 *               plan_id:
 *                 type: string
 *                 description: Plan ID
 *     responses:
 *       201:
 *         description: Subscription created successfully
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
 *                   description: Subscription object
 */
subsRoutes.post('/subscribe', noActiveSubscription, createSubscription)
/**
 * @swagger
 * /subscribe/user/{id}:
 *   get:
 *     tags:
 *       - Subscription
 *     summary: Get user subscription
 *     parameters:
 *       - name: id
 *         in: path
 *         required: true
 *         type: string
 *         example: 1234
 *         description: User ID
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
 *                   description: Subscription object
 * 
 */
subsRoutes.get('/user/:id', getUserSubscription)
/**
 * @swagger
 * /unsubscribe:
 *   post:
 *     tags:
 *       - Subscription
 *     summary: Cancel subscription
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               user_id:
 *                 type: string
 *                 description: User ID
 *     responses:
 *       200:
 *         description: Subscription canceled successfully
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
 *                   description: Subscription object
 * 
 */
subsRoutes.post('/unsubscribe', cancelSubscription)
/**
 * @swagger
 * /subscribe/history/{user_id}:
 *   get:
 *     tags:
 *       - Subscription
 *     summary: Get user subscription history
 *     parameters:
 *       - name: user_id
 *         in: path
 *         required: true
 *         type: string
 *         example: 1234
 *         description: User ID
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
 *                   type: array
 *                   description: Array of subscriptions
 * 
 */
subsRoutes.get('/history/:user_id', getUserSubscriptionHistory);


export default subsRoutes