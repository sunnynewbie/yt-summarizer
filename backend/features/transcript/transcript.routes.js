
import { Router } from 'express';
import { transcriptFn } from './transcript.controller.js';

const transcriptRoute = Router();

transcriptRoute.post('/',transcriptFn );

export default transcriptRoute;