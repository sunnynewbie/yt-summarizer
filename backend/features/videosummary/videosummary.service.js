// Service logic 
import { OpenAI } from 'openai';
import dotenv from 'dotenv';
dotenv.config();

const openai = new OpenAI({ apiKey: process.env.open_ai_key });

export async function generateSummary(transcript) {
    try {

        const res = await fetch('http://localhost:11434/api/generate', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                model: 'mistral',
                prompt: 'Summarize this text: ' + transcript,
                "stream": false, // important for single full response
            })

        });

        const data = await res.json();
        return data.response;

    } catch (error) {
        console.log(error);
        return null
    }
}
