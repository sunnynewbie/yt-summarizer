# API Deployment Notes

## Architecture

- Render hosts this Node.js API.
- RunPod hosts the external worker.
- The API creates jobs, stores state in Postgres, dispatches work to the worker, and exposes status/result endpoints.

## Required environment variables

Use [.env.example](/c:/Users/sunny/project_call/yt-summarizer/backend/.env.example) as the baseline.

- `PORT`
- `API_BASE_URL`
- `CORS_ORIGIN`
- `DB_HOST`
- `DB_PORT`
- `DB_USER`
- `DB_PASSWORD`
- `DB_NAME`
- `ACCESS_TOKEN_SECRET`
- `REFRESH_TOKEN_SECRET`
- `WORKER_URL`
- `WORKER_API_KEY`
- `WORKER_SUBMIT_PATH`
- `WORKER_CALLBACK_SECRET`

## Local setup

1. Create `.env` from `.env.example`.
2. Apply the SQL migrations in [README.md](/c:/Users/sunny/project_call/yt-summarizer/backend/migrations/README.md).
3. Start Postgres.
4. Start both local processes with `npm run run:local`, or run `run-local.bat`.
5. If you prefer manual startup, run `npm run dev` for the API and `npm run dev:worker` for the local mock worker.

## Worker contract

The API submits jobs to:

- `POST {WORKER_URL}{WORKER_SUBMIT_PATH}`

Expected request body:

```json
{
  "jobId": "uuid",
  "url": "https://youtube.com/...",
  "callbackUrl": "https://api.example.com/start-summerize/{jobId}/callback",
  "callbackAuth": {
    "algorithm": "hmac-sha256",
    "headerTimestamp": "x-worker-timestamp",
    "headerSignature": "x-worker-signature"
  }
}
```

The worker should call back to:

- `POST /start-summerize/{jobId}/callback`

Expected callback body fields:

- `status`
- `progress`
- `transcript`
- `summary`
- `transcript_url`
- `summary_url`
- `error_message`

The callback must send:

- `x-worker-timestamp`
- `x-worker-signature`

The signature is:

- `hex(HMAC_SHA256(WORKER_CALLBACK_SECRET, "{timestamp}.{raw_json_body}"))`

The worker must compute that signature itself using its own `WORKER_CALLBACK_SECRET`.

## Local development mode

For local API testing without RunPod or the AI pipeline:

- Set `WORKER_URL=http://localhost:8000`
- Set `WORKER_PORT=8000`
- Use the same `WORKER_CALLBACK_SECRET` in both processes
- Run `npm run dev` for the API
- Run `npm run dev:worker` for the mock worker

The mock worker only simulates the external worker lifecycle. It does not perform transcription or summarization.

## Render notes

- Set `API_BASE_URL` to the Render public service URL.
- Restrict `CORS_ORIGIN` to the frontend origin.
- Use strong random values for token and callback secrets.
- Do not enable database logging in production.
