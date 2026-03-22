BEGIN;

CREATE TABLE IF NOT EXISTS public.audit_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id UUID NULL,
  actor_user_id UUID NULL REFERENCES public.users(id) ON DELETE SET NULL,
  actor_role TEXT NULL,
  action TEXT NOT NULL,
  feature_area TEXT NULL,
  resource_type TEXT NULL,
  resource_id TEXT NULL,
  http_method TEXT NOT NULL,
  route_path TEXT NULL,
  status_code INTEGER NOT NULL,
  outcome TEXT NOT NULL,
  ip_address TEXT NULL,
  user_agent TEXT NULL,
  client_origin TEXT NULL,
  duration_ms INTEGER NULL,
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'audit_logs_outcome_check'
  ) THEN
    ALTER TABLE public.audit_logs
      ADD CONSTRAINT audit_logs_outcome_check
      CHECK (outcome IN ('success', 'rejected', 'error'));
  END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_audit_logs_actor_user_id
  ON public.audit_logs (actor_user_id);

CREATE INDEX IF NOT EXISTS idx_audit_logs_action_created_at
  ON public.audit_logs (action, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_audit_logs_feature_area_created_at
  ON public.audit_logs (feature_area, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_audit_logs_created_at
  ON public.audit_logs (created_at DESC);

COMMIT;
