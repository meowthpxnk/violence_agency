---
id: frontend.launch
scope: frontend
status: active
---

# Frontend launch

## Rule

The frontend is a Next.js 16 app. Install dependencies from package.json and run the Next.js dev server for local UI work. The container uses the frontend Dockerfile and docker-compose.yml. The image name is sozvezdie-frontend. The process listens on port 3000 and is published on port 3002. The Compose network nginx_appnet is external. Public URLs are NEXT_PUBLIC_* build arguments.

## Why

The browser bundle only sees variables that were present at build time.

## Exceptions

A unit test that does not boot Next.js does not need the Docker image. A change to a public URL does.
