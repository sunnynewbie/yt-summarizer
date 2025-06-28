import express from 'express';
import { sumbitVideo } from './video_process.controller.js';

var videoProcessRouter = express.Router();

videoProcessRouter.post('/submit', sumbitVideo);
videoProcessRouter.get('/status/:id', async (req, res) => { });

export default videoProcessRouter;