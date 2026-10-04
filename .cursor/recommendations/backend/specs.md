---
id: backend.specs
scope: backend
status: active
---

# Query specs

## Rule

A repository reads optional filters and eager-load flags from a dataclass spec in app/repositories/specs/. It adds a where clause or a selectinload only for a flag that is set. A spec with no lookup key raises ValueError. The sample is in the specs rule.

## Why

Callers ask for the graph they need. The query does not always join every relation.

## Exceptions

A list method may take explicit keyword filters when the screen has one search box and a limit.
