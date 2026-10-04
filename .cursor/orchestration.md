# Orchestration

The user talks to the root agent. The root agent launches specialists. A specialist may launch one more level of subagents. A micro-agent stops there.

```text
user -> root -> backend or frontend -> micro
                     |                     |
                     +--> reviewer <-------+
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

1. `backend` or `frontend` splits the task by files. One `micro` agent gets one subtask.
2. Two micro-agents do not edit the same file. Independent subtasks run in parallel.
3. The parent checks the micro reports.
4. The parent sends the combined diff to `reviewer-backend` or `reviewer-frontend`.
5. `verdict: approve` goes back to the root agent, then to the user.
6. `verdict: changes` gets one fix pass. A second rejection stops the loop. The root agent reports the open notes.

## What each side may read

`backend` and `reviewer-backend` read scope `backend` plus `stack`, `comments`, `naming`, `docs`, `cicd`, and `modularity`.

`frontend` and `reviewer-frontend` read scope `frontend` plus those same shared scopes.

They skip `draft` files and the other side's scope. Code samples are in `.cursor/rules/`, not in the recommendation files.

## Micro report

```text
files:
summary:
verify:
```

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
