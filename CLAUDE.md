# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Activate virtualenv
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run dev server (auto-reload)
fastapi dev api/main.py --port 8000

# Run production server
gunicorn -w 4 -k uvicorn.workers.UvicornWorker api.main:app
```

## Architecture

FastAPI app under `api/`, structured around a single SQLite database (`workout_app.db` at the repo root).

**Request flow:** `main.py` → router → depends on `deps.py` for db session and auth.

**`deps.py`** is the shared dependency hub — it exports three things consumed across routers:
- `db_dependency`: injects a SQLAlchemy `Session`
- `user_dependency`: decodes the JWT and returns `{id, username, name}` — use this to protect any authenticated endpoint
- `bcrypt_context`: for hashing/verifying passwords

**Auth** (`routers/auth.py`): JWT bearer tokens signed with `AUTH_SECRET_KEY` using `AUTH_ALGORITHM` (both from `.env`). Tokens expire in 20 minutes and encode `id`, `username`, and `name`.

**CORS** is configured in `main.py` to allow only the origin set by `API_URL` in `.env` (defaults to `http://localhost:3000`).

## Environment

`.env` must define:
- `AUTH_SECRET_KEY` — JWT signing key
- `AUTH_ALGORITHM` — e.g. `HS256`
- `API_URL` — frontend origin allowed by CORS
