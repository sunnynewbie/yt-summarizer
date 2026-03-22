import express from 'express';
import { noActiveSubscription } from '../../middlewares/noActiveSubscription.middleware.js';
import { cancelSubscription, createSubscription, getCurrentSubscription, getUserSubscriptionHistory } from './subscriptions.controller.js';
import { requireAuth } from '../../utils/auth.guards.js';

const subsRoutes = express.Router();

/**
 * @swagger
 * /subscriptions/subscribe:
 *   post:
 *     tags:
 *       - Subscription
 *     summary: Create a subscription for the current user
 *     security:
 *       - Authorization: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - plan_id
 *             properties:
 *               plan_id:
 *                 type: string
 *                 description: Subscription plan ID
 *     responses:
 *       201:
 *         description: Subscription created
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
 *         description: Validation error or active subscription already exists
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *       404:
 *         description: Subscription plan not found
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *       500:
 *         description: Internal server error
 */
subsRoutes.post('/subscribe', requireAuth, noActiveSubscription, createSubscription);

/**
 * @swagger
 * /subscriptions/me:
 *   get:
 *     tags:
 *       - Subscription
 *     summary: Get current active subscription
 *     security:
 *       - Authorization: []
 *     responses:
 *       200:
 *         description: Current subscription
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   type: object
 *       404:
 *         description: No active subscription found
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *       500:
 *         description: Internal server error
 */
subsRoutes.get('/me', requireAuth, getCurrentSubscription);

/**
 * @swagger
 * /subscriptions/unsubscribe:
 *   post:
 *     tags:
 *       - Subscription
 *     summary: Cancel current active subscription
 *     security:
 *       - Authorization: []
 *     responses:
 *       200:
 *         description: Subscription cancelled
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *       404:
 *         description: No active subscription found
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *       500:
 *         description: Internal server error
 */
subsRoutes.post('/unsubscribe', requireAuth, cancelSubscription);

/**
 * @swagger
 * /subscriptions/history:
 *   get:
 *     tags:
 *       - Subscription
 *     summary: Get subscription history for the current user
 *     security:
 *       - Authorization: []
 *     responses:
 *       200:
 *         description: Subscription history
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   type: array
 *       500:
 *         description: Internal server error
 */
subsRoutes.get('/history', requireAuth, getUserSubscriptionHistory);

export default subsRoutes;
