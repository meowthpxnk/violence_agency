---
id: comments.sections
scope: comments
status: active
---

# Section markers

## Rule

When a file has more than one responsibility, split large blocks with a short marker. Python file sections use `# -->`. Python class sections use `# ->`. TypeScript file sections use `// -->`. TypeScript component sections use `// ->`.

## Why

A reader can jump to the block they need.

## Exceptions

A file with one obvious responsibility does not need a marker.
