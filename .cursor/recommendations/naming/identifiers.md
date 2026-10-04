---
id: naming.identifiers
scope: naming
status: active
---

# Identifiers

## Rule

Python modules and functions use snake_case. Classes and components use PascalCase. SQLAlchemy table names use camel_to_snake of the class name. Environment aliases are SCREAMING_SNAKE. API schemas use names such as PostItemRequest and GetItemResponse. Frontend feature folders use kebab-case. FSD aliases are @app, @pages, @widgets, @features, @entities, and @shared.

## Why

The database, the API, and the FSD folders already follow these shapes.

## Exceptions

A third-party name stays as that library spells it.
