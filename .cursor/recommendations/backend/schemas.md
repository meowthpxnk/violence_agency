---
id: backend.schemas
scope: backend
status: active
---

# Schemas and enums

## Rule

Cover request and response bodies with Pydantic models. Cover stored statuses with enum.Enum. Do not accept a raw dict as a public contract. Name a write model PostItemRequest and a read model GetItemResponse. The sample is in the schemas rule.

## Why

The router and the service then share one contract.

## Exceptions

A spec dataclass used only to build a SQL query is not a Pydantic schema. It stays in app/repositories/specs/.
