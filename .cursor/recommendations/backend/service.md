---
id: backend.service
scope: backend
status: active
---

# Service owns the use case

## Rule

A service holds business decisions that are not SQL. It loads rows through repositories, checks rules, writes through repositories, and commits the session. A service may call another service. A router may call a service and must not reimplement the rule. The UserService sample is in the service rule.

## Why

Payment, moderation, and catalog rules stay testable without an HTTP request.

## Exceptions

None for a new use case. When you touch a repository that already commits, move that commit to the service.
