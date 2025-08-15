// Controller logic 
import { v4 as uuidv4 } from 'uuid';
import users from '../../models/users.js';
import refreshTokens from '../../models/refresh_tokens.js';
import { comparePassword, generateAccessToken, generateRefreshToken, hashPassword } from '../../utils/auth_helper.js';
import jwt from 'jsonwebtoken';

async function register(req, res, next) {
    const t = await users.sequelize.transaction(); // optional txn
    try {
        const { email, password, name } = req.body;

        /* 1) Validate */
        if (!email || !password)
            return res.status(400).json({ error: 'Email & password required.' });
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email))
            return res.status(400).json({ error: 'Invalid email.' });

        /* 2) Already exists? */
        const existing = await users.findOne({ where: { email }, transaction: t });
        if (existing) {
            await t.rollback();
            return res.status(409).json({ error: 'Email already in use.' });
        }

        /* 3) Hash pwd & create user */
        const password_hash = await hashPassword(password);
        const trial_expires_at = new Date(
            Date.now() + 7 * 24 * 60 * 60 * 1000
        );

        const user = await users.create(
            {
                id: uuidv4(),
                email: email.toLowerCase(),
                name,
                password_hash,
                role: 'user',
                trial_expires_at,
            },
            { transaction: t }
        );

        /* 4) Tokens */
        const accessToken = generateAccessToken({
            id: user.id,
            email: user.email,
            role: user.role,
            trial_expires_at,
        });
        const token = generateRefreshToken({ id: user.id });

        await refreshTokens.create(
            {
                id: uuidv4(),
                user_id: user.id,
                token: token,
                expires_at: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
            },
            { transaction: t }
        );

        await t.commit();
        return res.status(201).json({ accessToken, token });
    } catch (err) {
        await t.rollback();
        console.error('Sequelize register error:', err);
        return res.status(500).json({ error: 'Internal server error.' });
    }
}

async function login(req, res) {
    const t = await users.sequelize.transaction();
    try {
        const { email, password } = req.body;

        if (!email || !password)
            return res.status(400).json({ error: 'Email and password are required.' });

        const user = await users.findOne({ where: { email }, transaction: t });
        if (!user)
            return res.status(401).json({ error: 'Invalid email or password.' });

        if (!user.password_hash)
            return res.status(403).json({ error: 'This account uses Google login.' });

        const passwordMatch = await comparePassword(password, user.password_hash);
        if (!passwordMatch)
            return res.status(401).json({ error: 'Invalid email or password.' });

        const accessToken = generateAccessToken({
            id: user.id,
            email: user.email,
            role: user.role,
            trial_expires_at: user.trial_expires_at,
        });

        const token = generateRefreshToken({ id: user.id });

        await refreshTokens.create(
            {
                user_id: user.id,
                token: token,
                expires_at: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
            },
            { transaction: t }
        );

        await t.commit();
        var data = { accessToken, token };
        return res.status(200).json({ status: true, message: 'Login successfully', data: data });
    } catch (err) {
        await t.rollback();
        console.error('Login error:', err);
        return res.status(500).json({ error: 'Internal server error.' });
    }

}

async function logout(req, res) {
    try {
        const { refreshToken } = req.body;

        // 1) basic check
        if (!refreshToken)
            return res.status(400).json({ error: 'refreshToken is required.' });

        /* 2) Try verifying the token so we can return a cleaner error
              (even if verification fails we’ll still remove it from DB) */
        try {
            jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET);
        } catch (verifyErr) {
            // token might be expired/invalid – we ignore here, because
            // we can still remove it from DB if it exists.
        }

        // 3) Delete the token record (single‑device logout)
        const deleted = await refreshTokens.destroy({ where: { token: refreshToken } });

        if (!deleted)
            return res.status(404).json({ error: 'Token already invalid or not found.' });

        return res.status(200).json({ message: 'Logged out successfully.' });
    } catch (err) {
        console.error('Logout error:', err);
        return res.status(500).json({ error: 'Internal server error.' });
    }

}

async function refreshaccesstoken(req, res) {
    try {
        const { refreshToken } = req.body;

        // 1. Validate
        if (!refreshToken)
            return res.status(400).json({ error: 'refreshToken is required.' });

        // 2. Check if token exists in DB
        const tokenRecord = await refreshTokens.findOne({ where: { token: refreshToken } });
        if (!tokenRecord)
            return res.status(401).json({ error: 'Invalid refresh token.' });

        // 3. Verify JWT
        let payload;
        try {
            payload = jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET);
        } catch (err) {
            console.log(err);
            return res.status(401).json({ error: 'Expired or invalid refresh token.' });
        }

        // 4. Get user
        const user = await users.findByPk(payload.id);
        if (!user)
            return res.status(404).json({ error: 'User not found.' });

        // 5. Generate new access token
        const newAccessToken = generateAccessToken({
            id: user.id,
            email: user.email,
            role: user.role,
            trial_expires_at: user.trial_expires_at,
        });

        return res.status(200).json({ accessToken: newAccessToken });
    } catch (err) {
        console.error('Refresh token error:', err);
        return res.status(500).json({ error: 'Internal server error.' });
    }

}

async function getUser(req, res) {
    return res.status(200).json({ success: true, message: 'User fetched successfully', data: req.user.toJSON() });
}

export { register, login, logout, refreshaccesstoken, getUser };
