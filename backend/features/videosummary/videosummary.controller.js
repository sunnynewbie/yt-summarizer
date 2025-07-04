
import e from "express";
import jobs from "../../models/jobs.js";
import { generateSummary } from "./videosummary.service.js";

export async function summarizeVideo(req, res, next) {
    try {
        var request = req.body;
        if (request == null || request.transcript == null || request.transcript == undefined) {
            return res.status(403).json({ success: false, message: 'No transcript provided' });
        }
        var result = await generateSummary(request.transcript);
        return res.status(200).json({ success: true, message: 'Video summarized successfully', summary: result });
    } catch (error) {
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }
}

export async function getSummaryById(req, res) {
    try {
        
        var param = req.params.id
        var getJob = await jobs.findOne({ where: { id: param } })
        return res.status(200).json({ success: true, message: 'Video summarized successfully', summary: getJob.toJSON() });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }

}

export async function getAllSummary(req, res) {
    try {
        var getJob = await jobs.findAll();
        return res.status(200).json({ success: true, message: 'Video summarized successfully', summary: getJob.map(j => j.toJSON()) });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ success: false, message: 'Unkown error', error: error });
    }
}