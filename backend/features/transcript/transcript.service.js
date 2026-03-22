import { execFile } from 'child_process';
import { env } from '../../config/env.js';

export function transcribeLocally(audioPath, scriptPath) {
    return new Promise((resolve, reject) => {
        const args = [scriptPath, audioPath];
        if (env.ffmpegPath) {
            args.push('--ffmpeg-path', env.ffmpegPath);
        }

        execFile('python', args, { maxBuffer: 1024 * 1024 * 5 }, (error, stdout, stderr) => {
            if (error) {
                console.error('Whisper error:', stderr || error.message);
                return reject(stderr || error.message);
            }

            if (!stdout || stdout.trim() === '') {
                return reject('No transcript found in output.');
            }

            return resolve(stdout);
        });
    });
}
