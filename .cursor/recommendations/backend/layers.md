---
id: backend.layers
scope: backend
status: active
---

# Request layers

## Rule

A request moves downward: router, service, repository, model. The entrypoint is run.py. The package is app. HTTP lives in app/api, business in app/services, data access in app/repositories, models in app/models, contracts in app/schemas, outside clients in app/integrations, and infrastructure in app/core. Routers do not query the database. Repositories do not call integrations.

## Why

Each agent can take one layer without rewriting the ones above it.

## Exceptions

A tiny health route may read a ping from app.core when it has no business rule.
