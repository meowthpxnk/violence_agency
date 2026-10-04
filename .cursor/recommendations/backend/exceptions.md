---
id: backend.exceptions
scope: backend
status: active
---

# Application exceptions

## Rule

Domain failures inherit AppException. The message and the identifiers live on the exception. Do not use a bare Exception for a case the API already knows. HTTP handlers turn those exceptions into responses. The sample is in the exceptions rule.

## Why

Services stay free of status codes, and the API logs one shape of failure.

## Exceptions

ValidationError from settings stays a RuntimeError at process start. That is configuration, not a domain failure.
