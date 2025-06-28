import { exec } from 'child_process';
import { dirname, resolve } from 'path';
import { fileURLToPath } from 'url';

export function transcribeLocally(audioPath, scriptPath) {
    return new Promise((resolve, reject) => {

        // Get the current module's URL
        const command = `python ${scriptPath} ${audioPath}`;
        console.log(command);

        exec(command, { maxBuffer: 1024 * 1024 * 5 }, (error, stdout, stderr) => {
            if (error) {
                console.error('❌ Whisper error:', stderr || error.message);
                return reject(stderr || error.message);
            }
            var result = stdout

            if (!stdout || stdout.trim() === '') {
                return reject('❌ No transcript found in output.');
            }
            return resolve(result);
        });
    });
}