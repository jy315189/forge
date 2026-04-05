---
description: "Database standards: schema design, migrations, queries, indexing, safety"
globs: "**/{migrations,models,entities,schema,db,database,repositories}/**"
---
# Database Standards

## Schema Design

- Table names: **plural**, snake_case (`users`, `order_items`)
- Column names: snake_case (`created_at`, `user_id`)
- Every table must have a primary key (prefer `id` with auto-increment or UUID)
- Every table must have `created_at` and `updated_at` timestamps
- Use `deleted_at` for soft deletes — never physically delete user data
- Foreign keys: `{referenced_table_singular}_id` (`user_id`, `order_id`)

## Data Types

- Booleans: prefix with `is_`, `has_`, `can_` (`is_active`, `has_verified`)
- Money: use integer cents (not float/decimal) — `price_cents INTEGER`
- Dates: store in UTC, convert in application layer
- Enums: use string values (not integers) for readability and migration safety
- JSON columns: only for truly schemaless data — prefer structured columns

## Migration Rules

- Migrations are **forward-only** — never edit a deployed migration
- One concern per migration file
- **Destructive changes** require a multi-step rollout:
  1. Add new column → deploy → migrate data → drop old column
- Always provide a **rollback** strategy (even if manual)
- Name migrations descriptively: `add_email_verified_to_users`, not `migration_042`
- Test migrations against a copy of production data before deploying

## Indexing

- Index every foreign key column
- Index columns used in `WHERE`, `ORDER BY`, `JOIN` clauses
- Composite indexes: put the most selective column first
- Don't over-index — each index slows writes
- Review query plans (`EXPLAIN`) for slow queries before adding indexes

## Query Standards

- Use parameterized queries — **NEVER** string concatenation for SQL
- Select specific columns — avoid `SELECT *` in production code
- Limit result sets — always use `LIMIT` for list queries
- Use transactions for multi-step operations that must be atomic
- Avoid N+1 queries: use joins or batch loading

## Safety

- **Backups**: automated daily, tested monthly
- **Connection pooling**: configure min/max connections per environment
- **Timeout**: set query timeout (30s default, shorter for user-facing)
- **Read replicas**: route read-heavy queries to replicas when available
- **No raw SQL in handlers**: use repository/DAO pattern for all DB access
