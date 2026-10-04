---
id: backend.database
scope: backend
status: active
---

# Database models

## Rule

Use SQLAlchemy 2 with an async engine and AsyncSession. expire_on_commit is false. Base builds __tablename__ with camel_to_snake. Models that need an integer primary key use WithIDMixin. ReprStrMixin hides password_hash. Relations used only for type checkers are imported under TYPE_CHECKING. Alembic lives in database/, compares types, and runs online migrations through asyncpg. The sample is in the database rule.

## Why

The table name, the primary key, and the migration path are already fixed.

## Exceptions

A model with a composite key does not use WithIDMixin. It still inherits Base.
