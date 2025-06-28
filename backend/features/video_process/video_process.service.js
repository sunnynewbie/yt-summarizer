import { resolve, join } from 'path';
import fs from 'fs';
import { exec } from 'child_process';
import { log } from 'console';

async function downloadAudio(youtubeUrl, outputFolder = './temp') {
  return new Promise((resolve, reject) => {
    // Ensure temp folder exists
    if (!fs.existsSync(outputFolder)) {
      fs.mkdirSync(outputFolder);
    }

    const outputTemplate = join(outputFolder, '%(id)s.%(ext)s');
    // yt-dlp command
    const command = `yt-dlp -f bestaudio --extract-audio --audio-format wav --audio-quality 0  --output "${outputTemplate}" ${youtubeUrl}`;
    console.log(command);

    exec(command, (error, stdout, stderr) => {
      console.log('STDOUT:', stdout);
      console.error('STDERR:', stderr);

      if (error) {
        console.error('❌ yt-dlp error:', stderr);
        return reject(error);
      }
      const combinedOutput = stdout + stderr;
      console.log('combinedOutput', combinedOutput);

      // Extract filename from output
      const match = combinedOutput.match(/Destination: (.+\.wav)/);
      if (match && match[1]) {
        const filePath = resolve(match[1]);
        console.log('✅ Audio downloaded:', filePath);
        return resolve(filePath);
      } else {
        return reject('Audio file not found in yt-dlp output.');
      }
    });
  });
};

export { downloadAudio }