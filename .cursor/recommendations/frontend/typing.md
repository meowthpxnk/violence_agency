---
id: frontend.typing
scope: frontend
status: active
---

# TypeScript typing

## Rule

Type props, hook results, and API payloads. Parse data that crosses the network with Zod. Do not type an API payload as any. A Redux slice and a TanStack Query result expose a named type.

## Why

The frontend boundary should fail at parse time, not at render time.

## Exceptions

A third-party component whose props are already typed does not need a parallel interface. A static asset does not need a Zod schema.
