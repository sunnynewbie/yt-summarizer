// Controller logic 

import subscriptionPlan from "../../models/subscription_plan.js";
import subscriptionsTbl from "../../models/subscriptions_tbl.js";

// ✅ Create a new subscription
export const createSubscription = async (req, res) => {
    const { user_id, plan_id } = req.body;

    // Check if user already has active subscription
    const existing = await subscriptionsTbl.findOne({ where: { user_id, is_active: true } });
    if (existing) {
        return res.status(400).json({ error: 'User already has an active subscription.' });
    }

    // Validate plan exists
    const plan = await subscriptionPlan.findByPk(plan_id);
    if (!plan) return res.status(404).json({ error: 'Subscription plan not found.' });

    const newSub = await subscriptionsTbl.create({ user_id, plan_id });
    res.status(201).json(newSub);
};

// ✅ Get active subscription for a user
export const getUserSubscription = async (req, res) => {
    const { user_id } = req.params;

    const subscription = await subscriptionsTbl.findOne({
        where: { user_id, is_active: true },
        include: subscriptionPlan
    });

    if (!subscription) return res.status(404).json({ error: 'No active subscription found.' });

    res.json(subscription);
};

// ✅ Cancel current subscription
export const cancelSubscription = async (req, res) => {
    const { user_id } = req.params;

    const [updated] = await subscriptionsTbl.update(
        { is_active: false, end_date: new Date() },
        { where: { user_id, is_active: true } }
    );

    if (updated === 0) return res.status(404).json({ error: 'No active subscription found.' });

    res.json({ message: 'Subscription cancelled.' });
};

// ✅ List all subscriptions for a user (history)
export const getUserSubscriptionHistory = async (req, res) => {
    const { user_id } = req.params;
    const subs = await subscriptionsTbl.findAll({
        where: { user_id },
        include: subscriptionPlan,
        order: [['start_date', 'DESC']]
    });
    res.json(subs);
};
