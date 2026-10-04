# Recommendation kit

These files tell the Cursor agents how to write code and how to change the rules themselves.

Every file in `.cursor/` except agent prompts is English. Agent prompts may be Russian. Code comments may be Russian.

## How a recommendation is stored

Each topic has one file under `.cursor/recommendations/<scope>/`. The scopes are `stack`, `backend`, `frontend`, `comments`, `naming`, `docs`, `cicd`, and `modularity`.

A file keeps this shape:

```markdown
---
id: backend.repository
scope: backend
status: active
---

# Repository does not commit

## Rule

## Why

## Exceptions
```

There is no Examples section and no code block in a recommendation file. The code sample lives in the matching `.mdc` rule. `status` is `draft` or `active`. Product agents read `active` only.

Backend advice stays in `backend`. Frontend advice stays in `frontend`. Both sides also read `stack`, `comments`, `naming`, `docs`, `cicd`, and `modularity`.

## How to change one

Edit the existing file for that topic. Add a new file only when the topic does not exist yet, and add a matching row to [recommendations/index.md](recommendations/index.md). Put any code sample in the existing rule for that topic.

1. Set `status: draft`.
2. Run `python .cursor/check_recommendations.py`.
3. Ask `reviewer-standards` to read the diff.
4. Set `status: active` only when both checks pass. If either fails, restore the previous text.

The `standards` agent follows the same steps. It does not edit the product application.

## Where to start

- Agent tree and handoff formats: [orchestration.md](orchestration.md)
- Registry of every recommendation: [recommendations/index.md](recommendations/index.md)
