import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
const SALT_ROUNDS = 12;

/* 🔑 Password helpers */
const hashPassword = (plain) => bcrypt.hash(plain, SALT_ROUNDS);
const comparePassword = (plain, hash) => bcrypt.compare(plain, hash);

/* 🔑 JWT helpers */
const generateAccessToken = (payload) =>
    jwt.sign(payload, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '15m' });

const generateRefreshToken = (payload) =>
    jwt.sign(payload, process.env.REFRESH_TOKEN_SECRET, { expiresIn: '7d' });

export { hashPassword, comparePassword, generateAccessToken, generateRefreshToken };