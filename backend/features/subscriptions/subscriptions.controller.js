import subscriptionPlan from "../../models/subscription_plan.js";
import subscriptionsTbl from "../../models/subscriptions_tbl.js";
import { setAuditContext } from "../../utils/audit.js";

export const createSubscription = async (req, res) => {
    try {
        const userId = req.user.id;
        const { plan_id } = req.body;

        if (!plan_id) {
            return res.status(400).json({ error: 'plan_id is required.' });
        }

        const existing = await subscriptionsTbl.findOne({ where: { user_id: userId, is_active: true } });
        if (existing) {
            return res.status(400).json({ error: 'User already has an active subscription.' });
        }

        const plan = await subscriptionPlan.findOne({ where: { id: plan_id, is_active: true } });
        if (!plan) {
            return res.status(404).json({ error: 'Subscription plan not found.' });
        }

        const newSub = await subscriptionsTbl.create({ user_id: userId, plan_id });
        setAuditContext(req, {
            action: 'subscriptions.create',
            featureArea: 'subscriptions',
            resourceType: 'subscription',
            resourceId: String(newSub.id),
            actorUserId: userId,
            actorRole: req.user?.role,
            metadata: { plan_id },
        });
        return res.status(201).json({ success: true, data: newSub.toJSON() });
    } catch (error) {
        console.error('Create subscription error:', error);
        return res.status(500).json({ error: 'Internal server error' });
    }
};

export const getCurrentSubscription = async (req, res) => {
    try {
        const subscription = await subscriptionsTbl.findOne({
            where: { user_id: req.user.id, is_active: true },
            include: [{ model: subscriptionPlan, as: 'plan' }]
        });

        if (!subscription) {
            return res.status(404).json({ error: 'No active subscription found.' });
        }

        setAuditContext(req, {
            action: 'subscriptions.current.read',
            featureArea: 'subscriptions',
            resourceType: 'subscription',
            resourceId: String(subscription.id),
            actorUserId: req.user.id,
            actorRole: req.user?.role,
            metadata: { active: subscription.is_active },
        });
        return res.status(200).json({ success: true, data: subscription.toJSON() });
    } catch (error) {
        console.error('Get subscription error:', error);
        return res.status(500).json({ error: 'Internal server error' });
    }
};

export const cancelSubscription = async (req, res) => {
    try {
        const [updated] = await subscriptionsTbl.update(
            { is_active: false, end_date: new Date() },
            { where: { user_id: req.user.id, is_active: true } }
        );

        if (updated === 0) {
            return res.status(404).json({ error: 'No active subscription found.' });
        }

        setAuditContext(req, {
            action: 'subscriptions.cancel',
            featureArea: 'subscriptions',
            resourceType: 'subscription',
            actorUserId: req.user.id,
            actorRole: req.user?.role,
        });
        return res.status(200).json({ success: true, message: 'Subscription cancelled.' });
    } catch (error) {
        console.error('Cancel subscription error:', error);
        return res.status(500).json({ error: 'Internal server error' });
    }
};

export const getUserSubscriptionHistory = async (req, res) => {
    try {
        const subs = await subscriptionsTbl.findAll({
            where: { user_id: req.user.id },
            include: [{ model: subscriptionPlan, as: 'plan' }],
            order: [['start_date', 'DESC']]
        });

        setAuditContext(req, {
            action: 'subscriptions.history.read',
            featureArea: 'subscriptions',
            resourceType: 'subscription',
            actorUserId: req.user.id,
            actorRole: req.user?.role,
            metadata: { count: subs.length },
        });
        return res.status(200).json({
            success: true,
            data: subs.map((sub) => sub.toJSON())
        });
    } catch (error) {
        console.error('Get subscription history error:', error);
        return res.status(500).json({ error: 'Internal server error' });
    }
};
