// middlewares/authGuards.js
import jwt from 'jsonwebtoken';
import User from '../models/users.js';
import 'dotenv/config';
import e from 'express';

/**
 * requireAuth
 * ───────────
 * Ensures the request carries a valid Bearer access‑token.
 * On success: attaches full user row to req.user & calls next().
 * On failure: 401 Unauthorized.
 */
const requireAuth = async (req, res, next) => {
    try {
        const auth = req.headers.authorization || '';
        const token = auth.startsWith('Bearer ') ? auth.split(' ')[1] : null;

        if (!token) return res.status(401).json({ error: 'Missing token.' });

        // 1. Verify JWT
        let payload;
        try {
            payload = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
        } catch (err) {
            return res.status(401).json({ error: 'Invalid or expired token.' });
        }

        // 2. (Optional but safer) pull fresh user from DB
        const user = await User.findByPk(payload.id);
        if (!user) return res.status(401).json({ error: 'User no longer exists.' });

        req.user = user;                       // attach user object
        return next();
    } catch (err) {
        console.error('requireAuth error:', err);
        return res.status(500).json({ error: 'Internal server error.' });
    }
};

/**
 * requireProOrActiveTrial
 * ───────────────────────
 * Allows:
 *   • pro users,
 *   • OR free users whose trial has not yet expired.
 * Blocks others with 403.
 */
const requireProOrActiveTrial = (req, res, next) => {
    try {
        const { role, trial_expires_at } = req.user; // req.user set by requireAuth

        const trialStillActive = new Date(trial_expires_at) > new Date();

        if (role === 'pro' || trialStillActive) return next();

        return res
            .status(403)
            .json({ error: 'Trial expired. Upgrade to Pro to continue.' });
    } catch (err) {
        console.error('requireProOrActiveTrial error:', err);
        return res.status(500).json({ error: 'Internal server error.' });
    }
};

/**
 * requireVerifiedIfTrialExpired
 * ─────────────────────────────
 * Use for routes where you only want email‑verified users
 * once the free trial is over.  Flow:
 *   • If trial active → allow (verified not required yet)
 *   • If trial over & email_verified true → allow
 *   • Else → 403 asking for verification
 */
const requireVerifiedIfTrialExpired = (req, res, next) => {
    try {
        const { trial_expires_at, email_verified } = req.user;

        const trialStillActive = new Date(trial_expires_at) > new Date();
        if (trialStillActive || email_verified) return next();

        return res
            .status(403)
            .json({ error: 'Please verify your email to continue.' });
    } catch (err) {
        console.error('requireVerifiedIfTrialExpired error:', err);
        return res.status(500).json({ error: 'Internal server error.' });
    }
};
export { requireAuth, requireProOrActiveTrial, requireVerifiedIfTrialExpired };