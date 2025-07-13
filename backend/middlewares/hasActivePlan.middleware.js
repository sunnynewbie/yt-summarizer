import subscriptionPlan from "../models/subscription_plan.js";
import subscriptionsTbl from "../models/subscriptions_tbl.js";

export const hasActivePlan = async (req, res, next) => {
    try {
        const userId = req.user?.id || req.body.user_id || req.params.user_id;

        if (!userId) return res.status(401).json({ error: 'User ID required' });

        const subscription = await subscriptionsTbl.findOne({
            where: { user_id: userId, is_active: true },
            include: subscriptionPlan
        });

        if (!subscription) {
            return res.status(403).json({ error: 'No active subscription found' });
        }

        req.userPlan = {
            plan_id: subscription.plan_id,
            plan_name: subscription.subscription_plan.plan_name,
            video_limit: subscription.subscription_plan.video_limit,
            minute_limit: subscription.subscription_plan.minute_limit,
        };

        next();
    } catch (error) {
        console.error('hasActivePlan error:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};
