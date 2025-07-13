import subscriptionsTbl from '../models/subscriptions_tbl.js';

export const noActiveSubscription = async (req, res, next) => {
    try {
        const userId = req.user?.id || req.body.user_id;

        if (!userId) {
            return res.status(400).json({ error: 'User ID missing from request.' });
        }

        const existing = await subscriptionsTbl.findOne({
            where: { user_id: userId, is_active: true }
        });

        if (existing) {
            return res.status(400).json({
                error: 'User already has an active subscription. Please cancel it before subscribing again.'
            });
        }
        next();
    } catch (err) {
        console.error('noActiveSubscription error:', err);
        res.status(500).json({ error: 'Internal server error' });
    }
};
