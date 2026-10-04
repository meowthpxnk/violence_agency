---
id: cicd.containers
scope: cicd
status: active
---

# Containers

## Rule

Ship each app from the Dockerfile already in that app. Local runs use Docker Compose. Production orchestration is Docker Swarm. The frontend image sozvezdie-frontend listens on port 3000 and is published on port 3002. It joins the external network nginx_appnet. Public API, media, and VK ID URLs are NEXT_PUBLIC_* build arguments.

## Why

The delivery tools are already Docker and Docker Swarm. A new pipeline wraps those files.

## Exceptions

This kit does not define a hosted CI vendor. Add a workflow only when the repository already has one, and keep it calling the same Dockerfiles.
