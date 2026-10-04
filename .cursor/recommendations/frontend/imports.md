---
id: frontend.imports
scope: frontend
status: active
---

# Downward imports

## Rule

Import only downward through FSD: app, pages, widgets, features, entities, shared. A lower layer does not import a higher one. Use the aliases @app, @pages, @widgets, @features, @entities, and @shared.

## Why

The dependency arrow stays the same in every screen.

## Exceptions

src/shared may still be imported by the older admin wrappers. New FSD code uses @shared.
