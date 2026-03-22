# SQL Migrations

This repository does not have a migration runner yet, so apply these SQL files manually in order.

## Order

1. `001_saas_schema_hardening.sql`
2. `002_jobs_backfill_template.sql`
3. `003_add_audit_logs.sql`

## Purpose

- `001_saas_schema_hardening.sql` aligns the current schema with the API changes and basic SaaS constraints.
- `002_jobs_backfill_template.sql` is intentionally manual because historical job ownership cannot be inferred safely.
- `003_add_audit_logs.sql` creates a standard audit trail table for product-safe event tracking.

## Important

- Do not force `jobs.user_id` to `NOT NULL` until you have backfilled every existing job row.
