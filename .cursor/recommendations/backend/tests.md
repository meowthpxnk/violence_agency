---
id: backend.tests
scope: backend
status: active
---

# Backend tests

## Rule

Put tests in tests/ and name files test_*.py. Pytest minimum is 6.0. The default options are -v -x --tb=short, and the project root is on pythonpath. A test may use assert. Do not hide a business rule that exists only in a test. The pytest table is in the tooling rule.

## Why

The first failure stops the run, and the reviewer can see which case broke.

## Exceptions

A migration check under database/ is not a pytest module.
