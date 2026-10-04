---
id: backend.startup
scope: backend
status: active
---

# Process startup

## Rule

run.py only calls startup and prints a forced exit or the unexpected error. startup loads environment variables, imports app.core, and checks live dependencies. Importing app.core constructs Redis, logging, settings, and other live clients. Do not construct those clients inside a router. The sample is in the startup rule.

## Why

One startup path means the API, the worker, and Alembic share the same settings load.

## Exceptions

A script that only prints help may skip startup. Anything that touches the database or Redis may not.
