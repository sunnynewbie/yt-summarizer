import { Op } from 'sequelize';
import dayjs from 'dayjs';
import userUsage from '../models/user_usage.js';

export const withinQuota = async (req, res, next) => {
    try {
        const userId = req.user?.id || req.body.user_id || req.params.user_id;
        if (!userId) return res.status(401).json({ error: 'User ID required' });

        if (!req.userPlan) {
            return res.status(400).json({ error: 'User plan info missing. Add hasActivePlan middleware first.' });
        }

        const month = dayjs().format('YYYY-MM');

        // Get current usage
        const usage = await userUsage.findOne({
            where: {
                user_id: userId,
                month_year: month
            }
        });

        const videosUsed = usage?.videos_used || 0;
        const minutesUsed = usage?.minutes_used || 0;

        // Check limits
        const overVideo = videosUsed >= req.userPlan.video_limit;
        const overMinutes = minutesUsed >= req.userPlan.minute_limit;

        if (overVideo || overMinutes) {
            return res.status(403).json({
                error: 'Quota exceeded',
                detail: {
                    videos_used: videosUsed,
                    minutes_used: minutesUsed,
                    plan_limit: req.userPlan
                }
            });
        }

        req.usage = { videosUsed, minutesUsed, month };
        next();
    } catch (err) {
        console.error('withinQuota error:', err);
        res.status(500).json({ error: 'Internal server error' });
    }
};
