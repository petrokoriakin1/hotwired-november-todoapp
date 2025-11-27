# Migration and sqlite setup log

This file records changes made to make migrations reliably runnable, and
documents commands to run during outages or blackouts.

2025-11-27 - Added files to help migrations run reliably

- Added `config/initializers/sqlite_extensions.rb` to require
  `sqlite_extensions/uuid` safely. If the gem is not present the app will
  log a warning instead of failing to boot.

- Added `lib/tasks/ensure_tmp_storage.rake` which creates `tmp/storage`
  and is enhanced to run before `db:migrate`.

Quick run instructions

1. Install gems:

```bash
bundle install
```

2. Run migrations (the Rake task ensures the `tmp/storage` directory exists):

```bash
bin/rails db:migrate
```

If you need to run migrations during a blackout (no network):

- Ensure gems are already installed on the machine (vendor/cache, or prebundled).
- Run `bin/rails db:migrate` as above. The initializer will not crash if the
  sqlite extensions gem is missing; a warning will be emitted instead.

Notes

- If you prefer the sqlite extension to be strictly required, change the
  initializer to re-raise the LoadError.

2025-11-27 - Completed: ran `bin/rails db:migrate` successfully on local machine.

- Added `config/boot.rb` require for `sqlite_extensions/uuid` so
  `config/database.yml` can reference the extension path during boot.
- Added `config/initializers/sqlite_uuid_type.rb` to map ActiveRecord's
  `:uuid` native type to a `varchar(36)` on SQLite, allowing migrations
  that use `id: :uuid` to work locally.
- Patched `db/schema.rb` to include the `sections` table for consistent
  schema loading (this mirrors the existing migrations which store UUIDs
  as strings for SQLite compatibility).

2025-11-27 - Squashed migrations and added CI

- Added `db/migrate/20231101000000_squashed_schema.rb` which creates the
  current schema in a single idempotent migration for new setups.
- Marked older app migrations as superseded (no-op) so history remains
  intact while avoiding duplicate object creation when starting from the
  squashed migration.
- Added `.github/workflows/ci.yml` to run RuboCop and the test suite on
  pushes and PRs to `main`.

If you'd like, I can revert the manual `db/schema.rb` edit and instead
regenerate it from migrations once you confirm the CI/production DB setup,
or I can update the migrations to consistently use `id: :string`.
