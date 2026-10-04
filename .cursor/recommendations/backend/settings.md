---
id: backend.settings
scope: backend
status: active
---

# Settings

## Rule

Each settings block is its own BaseSettings with a Field alias for the environment variable. The root Settings object builds every annotated block and collects validation errors into one RuntimeError. Read YAML through read_yaml and read_yaml_model, then validate the document with a Pydantic model. The sample is in the settings rule.

## Why

One missing variable should report every missing variable.

## Exceptions

A constant that is not configuration does not belong in settings.
