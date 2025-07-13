import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
const app = express();

import videoProcessRouter from './features/video_process/video_process.routes.js';
import summaryRoute from './features/videosummary/videosummary.routes.js';
import transcriptRoute from './features/transcript/transcript.routes.js';
import router from './features/main_job/main_job.routes.js';
import authRouter from './features/auth/auth.routes.js';
import { setupSwagger } from './docs/swagger.js';
import planRoutes from './features/plans/plans.routes.js';
import subsRoutes from './features/subscriptions/subscriptions.routes.js';
import rateLimit from 'express-rate-limit';

const limit = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100, // limit each IP to 100 requests per windowMs
    standardHeaders: true, // return rate limit info in the `RateLimit-*` headers
    legacyHeaders: false, // disable the `X-RateLimit-*` headers
    message: 'Too many requests, please try again later.',
    handler: (req, res, next) => {
        res.status(429).json({ error: 'Too many requests, please try again later.' });
    },
});

app.use(limit);
app.use(cors());
app.use(bodyParser.json());
app.use('/video_process', videoProcessRouter);
app.use('/summary', summaryRoute);
app.use('/transcript', transcriptRoute);
app.use('/start-summerize', router)
app.use('/auth', authRouter)
app.use('/plans', planRoutes)
app.use('/subscriptions', subsRoutes)

setupSwagger(app); // ✅ serve at /docs

export default app;