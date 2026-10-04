---
id: stack.core
scope: stack
status: active
---

# Primary stack

## Rule

Stay inside the primary stack. Add another library only when none of these tools can do the job, and say why in the change summary. Backend: Python 3.12, FastAPI, Uvicorn, Poetry, SQLAlchemy 2, Alembic, PostgreSQL 15, Redis 7, MongoDB, MinIO, RabbitMQ, JWT RS256, Pydantic Settings, Docker, Docker Swarm. Frontend: Next.js, React, TypeScript, Zod, Axios, TanStack Query, styled-components, Sass, lucide-react, sonner. The Sozvezdie frontend already uses Redux Toolkit for the cart, favorites, and session, plus Tailwind CSS 4, Framer Motion, and VK ID.

## Why

One stack keeps agents, reviewers, and images on the same tools.

## Exceptions

A library already imported by the Sozvezdie frontend may stay. Do not add a second one for the same job.
