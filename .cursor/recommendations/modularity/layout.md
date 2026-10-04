---
id: modularity.layout
scope: modularity
status: active
---

# Module layout

## Rule

Put a module where its responsibility already lives. On the backend, app/core constructs live clients, app/repositories talks to the database, app/services holds business decisions, app/api holds HTTP, and app/integrations holds outside clients. On the frontend, app/ only routes into src/fsd/pages. New screens do not start in src/shared.

## Why

A file in the wrong folder makes the next agent import it from the wrong side.

## Exceptions

Leave an existing empty package such as src/fsd/processes in place until a task needs it.
