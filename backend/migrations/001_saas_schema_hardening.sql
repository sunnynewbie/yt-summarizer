BEGIN;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

ALTER TABLE public.users
  ALTER COLUMN role SET DEFAULT 'user',
  ALTER COLUMN role SET NOT NULL,
  ALTER COLUMN email_verified SET DEFAULT false,
  ALTER COLUMN email_verified SET NOT NULL,
  ALTER COLUMN trial_expires_at SET DEFAULT (CURRENT_TIMESTAMP + INTERVAL '7 days');

UPDATE public.users
SET email = LOWER(TRIM(email))
WHERE email IS NOT NULL;

ALTER TABLE public.users
  ALTER COLUMN trial_expires_at SET NOT NULL;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_indexes
    WHERE schemaname = 'public' AND indexname = 'users_email_lower_key'
  ) THEN
    CREATE UNIQUE INDEX users_email_lower_key ON public.users (LOWER(email));
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'subscription_plan_video_limit_check'
  ) THEN
    ALTER TABLE public.subscription_plan
      ADD CONSTRAINT subscription_plan_video_limit_check CHECK (video_limit >= 0);
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'subscription_plan_minute_limit_check'
  ) THEN
    ALTER TABLE public.subscription_plan
      ADD CONSTRAINT subscription_plan_minute_limit_check CHECK (minute_limit >= 0);
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'subscription_plan_price_check'
  ) THEN
    ALTER TABLE public.subscription_plan
      ADD CONSTRAINT subscription_plan_price_check CHECK (price >= 0);
  END IF;
END $$;

ALTER TABLE public.subscription_plan
  ALTER COLUMN is_active SET DEFAULT true,
  ALTER COLUMN is_active SET NOT NULL;

ALTER TABLE public.subscriptions_tbl
  ALTER COLUMN user_id SET NOT NULL,
  ALTER COLUMN plan_id SET NOT NULL,
  ALTER COLUMN start_date SET DEFAULT CURRENT_TIMESTAMP,
  ALTER COLUMN start_date SET NOT NULL,
  ALTER COLUMN is_active SET DEFAULT true,
  ALTER COLUMN is_active SET NOT NULL;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'subscriptions_tbl_end_date_check'
  ) THEN
    ALTER TABLE public.subscriptions_tbl
      ADD CONSTRAINT subscriptions_tbl_end_date_check
      CHECK (end_date IS NULL OR end_date >= start_date);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_indexes
    WHERE schemaname = 'public' AND indexname = 'subscriptions_tbl_one_active_per_user_idx'
  ) THEN
    CREATE UNIQUE INDEX subscriptions_tbl_one_active_per_user_idx
      ON public.subscriptions_tbl (user_id)
      WHERE is_active = true;
  END IF;
END $$;

ALTER TABLE public.refresh_tokens
  ALTER COLUMN user_id SET NOT NULL,
  ALTER COLUMN expires_at SET NOT NULL;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_indexes
    WHERE schemaname = 'public' AND indexname = 'refresh_tokens_token_key'
  ) THEN
    CREATE UNIQUE INDEX refresh_tokens_token_key ON public.refresh_tokens (token);
  END IF;
  IF NOT EXISTS (
    SELECT 1
    FROM pg_indexes
    WHERE schemaname = 'public' AND indexname = 'idx_refresh_tokens_user_id'
  ) THEN
    CREATE INDEX idx_refresh_tokens_user_id ON public.refresh_tokens (user_id);
  END IF;
END $$;

ALTER TABLE public.user_usage
  ALTER COLUMN user_id SET NOT NULL,
  ALTER COLUMN videos_used SET DEFAULT 0,
  ALTER COLUMN videos_used SET NOT NULL,
  ALTER COLUMN minutes_used SET DEFAULT 0,
  ALTER COLUMN minutes_used SET NOT NULL,
  ALTER COLUMN last_updated SET DEFAULT CURRENT_TIMESTAMP,
  ALTER COLUMN last_updated SET NOT NULL;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'user_usage_videos_used_check'
  ) THEN
    ALTER TABLE public.user_usage
      ADD CONSTRAINT user_usage_videos_used_check CHECK (videos_used >= 0);
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'user_usage_minutes_used_check'
  ) THEN
    ALTER TABLE public.user_usage
      ADD CONSTRAINT user_usage_minutes_used_check CHECK (minutes_used >= 0);
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'user_usage_month_year_check'
  ) THEN
    ALTER TABLE public.user_usage
      ADD CONSTRAINT user_usage_month_year_check CHECK (month_year ~ '^[0-9]{4}-[0-9]{2}$');
  END IF;
END $$;

ALTER TABLE public.jobs
  ADD COLUMN IF NOT EXISTS user_id UUID,
  ALTER COLUMN status SET DEFAULT 'queued';

UPDATE public.jobs
SET status = CASE
  WHEN status IN ('downloading', 'transcribing', 'summarizing') THEN 'processing'
  WHEN status IS NULL OR BTRIM(status) = '' THEN 'queued'
  ELSE LOWER(BTRIM(status))
END;

UPDATE public.jobs
SET status = 'failed'
WHERE status NOT IN ('queued', 'dispatched', 'processing', 'completed', 'failed');

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'jobs_user_id_fkey'
  ) THEN
    ALTER TABLE public.jobs
      ADD CONSTRAINT jobs_user_id_fkey
      FOREIGN KEY (user_id) REFERENCES public.users(id)
      ON DELETE CASCADE;
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'jobs_status_check'
  ) THEN
    ALTER TABLE public.jobs
      ADD CONSTRAINT jobs_status_check
      CHECK (status IN ('queued', 'dispatched', 'processing', 'completed', 'failed'));
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_indexes
    WHERE schemaname = 'public' AND indexname = 'idx_jobs_user_id'
  ) THEN
    CREATE INDEX idx_jobs_user_id ON public.jobs (user_id);
  END IF;
END $$;

COMMIT;

-- Manual follow-up after backfilling existing jobs.user_id values:
-- ALTER TABLE public.jobs ALTER COLUMN user_id SET NOT NULL;
