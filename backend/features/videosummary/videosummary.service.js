import { env } from '../../config/env.js';

export async function generateSummary(transcript) {
    try {
        const prompt = [
            'Summarize the following transcript.',
            'Return concise bullet points.',
            'Capture key ideas, decisions, and action items if present.',
            '',
            transcript,
        ].join('\n');

        const res = await fetch(`${env.ollamaHost}/api/generate`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                model: env.ollamaModel,
                prompt,
                stream: false,
            }),
        });

        if (!res.ok) {
            const errorText = await res.text();
            throw new Error(`Ollama request failed with ${res.status}: ${errorText}`);
        }

        return await res.json();
    } catch (error) {
        console.log(error);
        return null;
    }
}
