import { Router } from 'express';
import { summarizeVideo } from './videosummary.controller.js';

var summaryRoute = Router();

summaryRoute.post('/',summarizeVideo);
export default summaryRoute;