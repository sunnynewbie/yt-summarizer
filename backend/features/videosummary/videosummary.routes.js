import { Router } from 'express';
import { getSummaryById, summarizeVideo } from './videosummary.controller.js';

var summaryRoute = Router();

summaryRoute.post('/', summarizeVideo);
summaryRoute.get('/:id', getSummaryById);
export default summaryRoute;