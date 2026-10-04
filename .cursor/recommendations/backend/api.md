---
id: backend.api
scope: backend
status: active
---

# HTTP API

## Rule

Build the FastAPI app in one place. Set docs_url to None. Store an ApiContext on app.state and read it through ApiContextDepends. Load CORS from config/cors.yaml into a Pydantic model. Register one default handler for Exception that logs the request and returns JSON with status 500. Aggregate routers in one module. A route asks for dependencies and does not construct clients. The sample is in the API rule.

## Why

Auth, the database session, and other clients stay available to every route.

## Exceptions

Static files for docs.html and the favicon stay in static/. They are not routers.
