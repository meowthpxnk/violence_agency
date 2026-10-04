---
id: backend.logging
scope: backend
status: active
---

# Logging

## Rule

Configure logging from config/logging.yaml with dictConfig when app.core.logging is imported. Formatters are BaseFormatter and ColorisedFormatter. The YAML settings block maps onto FormatterSettings. In a service or a router, use logging.getLogger(__name__). Log a failure that includes a traceback with exc_info=True. The sample is in the logging rule.

## Why

The process, Uvicorn, and Alembic share one configuration.

## Exceptions

run.py may print the startup failure and the keyboard interrupt. Logging is not ready when those lines run.
