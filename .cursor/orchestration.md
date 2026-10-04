# Orchestration

The user talks to the root agent. The root agent launches specialists. A specialist may launch its reviewer. It does not launch another implementation agent.

```text
user -> root -> backend or frontend -> reviewer-backend or reviewer-frontend
root -> standards -> reviewer-standards
```

## When to launch someone

| Prompt | Agent |
| --- | --- |
| Question, no code change | root answers |
| Python, FastAPI, database, API | `backend` |
| TypeScript, React, Next.js, `src/fsd` | `frontend` |
| Both sides of one task | `backend` and `frontend` in one step |
| Add or correct a recommendation or Cursor file | `standards` |

The root agent writes the whole task into the subagent prompt. Subagents do not see the chat.

## How product work moves

1. The root agent launches `backend` and/or `frontend`. Launch both in one step when the task needs both.
2. `backend` and `frontend` implement the task themselves. They do not launch a micro-agent, and they do not split the work into per-file micro subagents.
3. The specialist sends the combined diff to `reviewer-backend` or `reviewer-frontend`.
4. `verdict: approve` goes back to the root agent, then to the user.
5. `verdict: changes` gets one fix pass. A second rejection stops the loop. The root agent reports the open notes.

## What each side may read

`backend` and `reviewer-backend` read scope `backend` plus `stack`, `comments`, `naming`, `docs`, `cicd`, and `modularity`.

`frontend` and `reviewer-frontend` read scope `frontend` plus those same shared scopes.

They skip `draft` files and the other side's scope. Code samples are in `.cursor/rules/`, not in the recommendation files.

## Reviewer verdict

```text
verdict: approve
notes:
- none
```

```text
verdict: changes
notes:
- path: what to fix
```

## Standards check

`standards` edits the existing recommendation file and the matching rule. It sets `draft`, runs `python .cursor/check_recommendations.py`, and sends the diff to `reviewer-standards`. Both must pass before `status` becomes `active`. A failed check restores the previous text. Recommendation text and rule text are English.
