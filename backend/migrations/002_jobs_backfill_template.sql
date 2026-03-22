BEGIN;

-- Replace this with a real ownership mapping before running in a shared environment.
-- Example for a single local test user:
-- UPDATE public.jobs
-- SET user_id = '00000000-0000-0000-0000-000000000000'
-- WHERE user_id IS NULL;

-- Review any remaining unowned jobs:
-- SELECT id, video_url
-- FROM public.jobs
-- WHERE user_id IS NULL;

-- Only after every row has a valid owner:
-- ALTER TABLE public.jobs ALTER COLUMN user_id SET NOT NULL;

COMMIT;
