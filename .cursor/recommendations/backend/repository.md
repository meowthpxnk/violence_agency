---
id: backend.repository
scope: backend
status: active
---

# Repository does not commit

## Rule

A repository talks to the database only. It may select, insert, update, delete, filter, sort, paginate, and eager-load. It does not contain business rules, does not call other services, and does not commit. The UserRepository sample is in the repository rule.

## Why

The service owns the transaction so one use case can call several repositories and commit once.

## Exceptions

flush is allowed when the caller needs a database-generated id before the service commits.
