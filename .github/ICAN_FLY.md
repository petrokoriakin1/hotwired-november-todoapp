**ICAN_FLY — Repo & Fly context dump**

**Date:** 2025-11-27

**Repository:** `hotwired-november-todoapp`
**Path:** `/Users/petro/joy/gh/hotwired-november-todoapp`
**Branch:** `main`

**Summary**:
- **Purpose:** Notes about a missing `secret_key_base` in production, the fix I applied locally, and the Fly deployment secret I set.
- **Sensitive data:** Do NOT store secrets in this file. The actual `SECRET_KEY_BASE` value set in Fly is intentionally omitted.

**What I changed locally**:
- **File updated:** `bin/docker-entrypoint` — added a runtime check that in `production` requires one of:
  - `SECRET_KEY_BASE` environment variable, or
  - `RAILS_MASTER_KEY` environment variable (for encrypted credentials), or
  - a `config/credentials/production.key` file (not recommended to include in the image).
- **Why:** Previously Rails raised `ArgumentError: Missing 'secret_key_base' for 'production' environment`. The new check exits early with a clear message explaining how to fix missing production secrets.

**Dockerfile notes**:
- The `Dockerfile` uses `SECRET_KEY_BASE_DUMMY=1` during the `assets:precompile` step so that precompilation can run in CI/build without secrets. This only affects the build stage. At runtime Rails still requires a real `secret_key_base`.

**Fly actions performed**:
- Generated a new random secret locally (not recorded here).
- Ran: `fly secrets set SECRET_KEY_BASE=<generated-secret>`
- Fly responded: "Secrets are staged for the first deployment" indicating the secret was accepted and staged.

**Quick commands**
- Generate a secret locally:
  - `ruby -rsecurerandom -e 'puts SecureRandom.hex(64)'
- Set secret on Fly:
  - `fly secrets set SECRET_KEY_BASE=...`
- Deploy to apply staged secrets:
  - `fly deploy`

**Alternative (use encrypted credentials)**
- Create production credentials (recommended if you prefer encrypted credentials):
  - `EDITOR="nano -w" ./bin/rails credentials:edit --environment production`
  - This creates `config/credentials/production.yml.enc` and `config/credentials/production.key`.
- On Fly: set `RAILS_MASTER_KEY` to the contents of `production.key` (do NOT commit the key):
  - `fly secrets set RAILS_MASTER_KEY=<the-key>`

**Security reminders**:
- Do not commit `config/credentials/production.key` or the plaintext secret to git.
- Use Fly secrets, a secrets manager, or environment variables provided by your CI/CD host.
- Rotate the secret periodically if you suspect leakage.

**Next recommended steps**:
- Run `fly deploy` to activate the staged secret.
- Or, if you prefer encrypted credentials, create `production.yml.enc` and set `RAILS_MASTER_KEY` on Fly instead, then remove the `SECRET_KEY_BASE` secret if you switch methods.

**Files of interest**:
- `bin/docker-entrypoint` (modified)
- `Dockerfile`
- `fly.toml`
- `config/credentials/production.yml.enc` (if present)
- `config/credentials/production.key` (do NOT commit)

**Contact / notes**:
- File created by automation on request — contains actionable steps but no secret values.
