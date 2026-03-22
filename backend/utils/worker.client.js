import axios from 'axios';
import { env } from '../config/env.js';

const workerClient = env.workerUrl
  ? axios.create({
      baseURL: env.workerUrl,
      timeout: 30000,
      headers: env.workerApiKey
        ? {
            Authorization: `Bearer ${env.workerApiKey}`,
          }
        : {},
    })
  : null;

export async function submitJobToWorker({ jobId, videoUrl }) {
  if (!workerClient) {
    throw new Error('WORKER_URL is not configured');
  }

  const callbackUrl = `${env.apiBaseUrl.replace(/\/$/, '')}/start-summerize/${jobId}/callback`;

  const response = await workerClient.post(env.workerSubmitPath, {
    jobId,
    url: videoUrl,
    callbackUrl,
    callbackAuth: env.workerCallbackSecret
      ? {
          algorithm: 'hmac-sha256',
          headerTimestamp: 'x-worker-timestamp',
          headerSignature: 'x-worker-signature',
        }
      : undefined,
  });

  return response.data;
}
