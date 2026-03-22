import express from 'express';
import cors from 'cors';
import rateLimit from 'express-rate-limit';
import './config/env.js';

import videoProcessRouter from './features/video_process/video_process.routes.js';
import summaryRoute from './features/videosummary/videosummary.routes.js';
import transcriptRoute from './features/transcript/transcript.routes.js';
import router from './features/main_job/main_job.routes.js';
import authRouter from './features/auth/auth.routes.js';
import { setupSwagger } from './docs/swagger.js';
import planRoutes from './features/plans/plans.routes.js';
import subsRoutes from './features/subscriptions/subscriptions.routes.js';
import { env } from './config/env.js';
import { auditMiddleware } from './middlewares/audit.middleware.js';
import { errorHandler, notFoundHandler } from './middlewares/error.middleware.js';

const app = express();

const configuredCorsOrigins = env.corsOrigin
    .split(',')
    .map((origin) => origin.trim())
    .filter(Boolean);

const localhostOriginPattern = /^https?:\/\/(localhost|127\.0\.0\.1|\[::1\])(?::\d+)?$/i;

const corsOptions = {
    origin(origin, callback) {
        if (!origin) {
            return callback(null, true);
        }

        if (configuredCorsOrigins.includes('*')) {
            return callback(null, true);
        }

        if (localhostOriginPattern.test(origin)) {
            return callback(null, true);
        }

        if (configuredCorsOrigins.includes(origin)) {
            return callback(null, true);
        }

        return callback(new Error(`CORS origin not allowed: ${origin}`));
    },
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization', 'X-Requested-With'],
};

const limit = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 100,
    standardHeaders: true,
    legacyHeaders: false,
    message: { error: 'Too many requests, please try again later.' },
});

app.disable('x-powered-by');
app.use(cors(corsOptions));
app.use(express.json({
    limit: '1mb',
    verify: (req, res, buf) => {
        req.rawBody = buf.toString('utf8');
    },
}));
app.use(auditMiddleware);

if (env.enableRateLimit) {
    app.use(limit);
}

app.get('/health', (req, res) => {
    res.status(200).json({
        success: true,
        status: 'ok',
        environment: env.nodeEnv,
    });
});

app.use('/video_process', videoProcessRouter);
app.use('/summary', summaryRoute);
app.use('/transcript', transcriptRoute);
app.use('/start-summerize', router);
app.use('/auth', authRouter);
app.use('/plans', planRoutes);
app.use('/subscriptions', subsRoutes);

setupSwagger(app);
app.use(notFoundHandler);
app.use(errorHandler);

export default app;
