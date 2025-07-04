import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
const app = express();

import videoProcessRouter from './features/video_process/video_process.routes.js';
import summaryRoute from './features/videosummary/videosummary.routes.js';
import transcriptRoute from './features/transcript/transcript.routes.js';
import router from './features/main_job/main_job.routes.js';


app.use(cors());
app.use(bodyParser.json());
app.use('/video_process', videoProcessRouter);
app.use('/summary', summaryRoute);
app.use('/transcript', transcriptRoute);
app.use('/start-summerize',router)

export default app;