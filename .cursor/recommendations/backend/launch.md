---
id: backend.launch
scope: backend
status: active
---

# Backend launch

## Rule

Install and run the backend with Poetry on Python 3.12. Install with poetry install. Start the API with python run.py. Keep Alembic scripts in database/. pyproject.toml sets script_location to database. Apply migrations with Alembic against DATABASE_URI. The image builds from the backend Dockerfile and starts through entrypoint.sh. Commands and the project file are in the startup and tooling rules.

## Why

run.py, Poetry, and Alembic are the three entry points already specified.

## Exceptions

A documentation-only change does not need a running database. A change to a model does.
