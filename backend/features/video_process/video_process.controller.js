import e from "express";
import { downloadAudio } from "./video_process.service.js";
import { setAuditContext } from "../../utils/audit.js";

function getHostname(value) {
    try {
        return new URL(value).hostname;
    } catch (error) {
        return null;
    }
}

async function sumbitVideo(req, res, next) {

    try {
        var request = req.body;
        if (request == null) {
            return res.status(403).json({
                success: false,
                message: 'No URL provided',
            })
        }
        if (request.url) {
            const audio = await downloadAudio(request.url, './temp');
            setAuditContext(req, {
                action: 'video_process.submit',
                featureArea: 'video_process',
                resourceType: 'video',
                metadata: {
                    source_host: getHostname(request.url),
                    output_generated: Boolean(audio),
                },
            });
            // var transcribed = await fetch('http://localhost:5000/transcript', {
            //     body: JSON.stringify({
            //         audio: audio
            //     }),
            //     headers: {
            //         'Content-Type': 'application/json'
            //     },
            //     method: 'POST'
            // })
            // let updatedTranscript = (await transcribed.json()).transcript
            // const summary = await fetch('http://localhost:5000/summary', {
            //     body: JSON.stringify({
            //         transcript: updatedTranscript
            //     }),
            //     headers: {
            //         'Content-Type': 'application/json'
            //     },
            //     method: 'POST'
            // })
            // let updatedSummary = await summary.json()
            
            return res.status(200).json({
                success: true,
                message: 'Audio downloaded successfully',
                audio: audio,
                // transcribed: updatedTranscript,
                // summary: updatedSummary.summary.response
            })
        }
        return res.status(403).json({
            success: false,
            message: 'No URL provided',
        })

    } catch (error) {
        console.log(error);

        return res.status(500).json({
            success: false,
            message: 'Unkown error',
            error: error
        })

    }
}

export { sumbitVideo }
