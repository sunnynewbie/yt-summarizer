import { resolve } from "path";
import { transcribeLocally } from "./transcript.service.js";

// Controller logic 
export async function transcriptFn(req, res, next) {
    try {
        var request = req.body;
        if (request == null || request.audio == null || request.audio == undefined) {
            return res.status(403).json({ success: false, message: 'No audio provided' });
        }
        var audio = request.audio;
        var fullPath = resolve(audio)
        const scriptPath = resolve('utils//local_transcribe.py');

        var transcript = await transcribeLocally(fullPath, scriptPath)
        return res.status(200).json({ success: true, message: 'Audio transcribed successfully', transcript: transcript });
    } catch (error) {
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }
}