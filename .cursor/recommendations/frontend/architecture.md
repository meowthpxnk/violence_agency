---
id: frontend.architecture
scope: frontend
status: active
---

# Frontend structure

## Rule

The Sozvezdie storefront uses Next.js 16 App Router, React 19, and TypeScript. Interface code lives in src/fsd. A route file in app/ only mounts a page from src/fsd/pages. State for the cart, favorites, and session is Redux Toolkit. Server data is TanStack Query. HTTP goes through Axios. src/shared and src/main_pages are the older layer. The full tree and the route list are in the frontend architecture rule.

## Why

A thin route file keeps the App Router tree stable while the screen changes inside FSD.

## Exceptions

An admin screen that is still a thin wrapper in src/main_pages may stay there until that screen is moved. Do not add a new feature to that folder.
