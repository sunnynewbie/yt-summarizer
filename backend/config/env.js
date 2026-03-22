import fs from 'fs';
import path from 'path';
import dotenv from 'dotenv';
import crypto from 'crypto';

const envFiles = [
  { path: path.resolve(process.cwd(), '..', '.env'), override: false },
  { path: path.resolve(process.cwd(), '.env'), override: false },
  { path: path.resolve(process.cwd(), '..', '.env.local'), override: true },
  { path: path.resolve(process.cwd(), '.env.local'), override: true },
];

for (const envFile of envFiles) {
  if (fs.existsSync(envFile.path)) {
    dotenv.config({ path: envFile.path, override: envFile.override });
  }
}

const parseInteger = (value, fallback) => {
  const parsed = Number.parseInt(value ?? '', 10);
  return Number.isNaN(parsed) ? fallback : parsed;
};

const parseBoolean = (value, fallback = false) => {
  if (value == null) return fallback;
  return ['1', 'true', 'yes', 'on'].includes(String(value).toLowerCase());
};

const requiredEnv = ['ACCESS_TOKEN_SECRET', 'REFRESH_TOKEN_SECRET'];

export const env = {
  nodeEnv: process.env.NODE_ENV || 'development',
  port: parseInteger(process.env.PORT, 5000),
  apiBaseUrl: process.env.API_BASE_URL || `http://localhost:${parseInteger(process.env.PORT, 5000)}`,
  corsOrigin: process.env.CORS_ORIGIN || '*',
  enableRateLimit: parseBoolean(process.env.ENABLE_RATE_LIMIT, true),
  ollamaHost: process.env.OLLAMA_HOST || 'http://localhost:11434',
  ollamaModel: process.env.OLLAMA_MODEL || 'qwen2.5-coder:7b',
  ffmpegPath: process.env.FFMPEG_PATH || '',
  workerUrl: process.env.WORKER_URL || '',
  workerApiKey: process.env.WORKER_API_KEY || '',
  workerSubmitPath: process.env.WORKER_SUBMIT_PATH || '/jobs',
  workerCallbackSecret: process.env.WORKER_CALLBACK_SECRET || '',
  webhookToleranceSeconds: parseInteger(process.env.WORKER_WEBHOOK_TOLERANCE_SECONDS, 300),
  db: {
    host: process.env.DB_HOST || 'localhost',
    port: parseInteger(process.env.DB_PORT, 5432),
    username: process.env.DB_USER || 'postgres',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'yt-summarize',
    logging: parseBoolean(process.env.DB_LOGGING, false),
  },
};

export function assertRequiredEnv() {
  const missing = requiredEnv.filter((key) => !process.env[key]);
  if (missing.length > 0) {
    throw new Error(`Missing required environment variables: ${missing.join(', ')}`);
  }
}

export function signWorkerPayload(payload, timestamp) {
  if (!env.workerCallbackSecret) {
    return '';
  }

  return crypto
    .createHmac('sha256', env.workerCallbackSecret)
    .update(`${timestamp}.${payload}`)
    .digest('hex');
}
