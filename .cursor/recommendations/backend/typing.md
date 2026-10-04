---
id: backend.typing
scope: backend
status: active
---

# Python typing

## Rule

Annotate functions and methods. Ruff selects E, W, F, I, UP, A, B, C4, SIM, and ANN. The line length is 79. Ignored ANN codes are ANN101, ANN102, and ANN204, plus F401. Tests may skip return and argument annotations and may use assert. Use Python 3.12 unions. Import a model under TYPE_CHECKING when the runtime import would be a cycle. Pydantic models cover API and database payloads. The whole project file is in the tooling rule.

## Why

The reviewer can reject a missing annotation without debating style.

## Exceptions

Do not add a new ignore for production code. The F401 ignore is already configured for re-export modules.
