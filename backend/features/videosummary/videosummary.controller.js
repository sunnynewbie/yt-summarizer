
import { generateSummary } from "./videosummary.service.js";

export async function summarizeVideo(req, res, next) {
    try {
        var request = req.body;
        if (request == null || request.transcript == null || request.transcript == undefined) {
            return res.status(403).json({ success: false, message: 'No transcript provided' });
        }
        console.log(request);
        
        var result = await generateSummary(request.transcript);
        return res.status(200).json({ success: true, message: 'Video summarized successfully', summary: result });
    } catch (error) {
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }
}