---
name: error-rule
description: Use for quick capture of a constraint after failure — when a full post-mortem is overkill but the lesson should not be lost.
---

# Error Rule (Quick Capture)

Shortcut for capturing a one-sentence constraint without a full post-mortem.

For significant sessions with multiple insights, use `/post-mortem` instead.

## When to Use

- Failed at same thing 2+ times in a session
- Debugging session revealed a non-obvious gotcha
- Hit a mistake you've hit before across sessions
- User says "never do that again" or "remember this"

## Process

1. **Identify the root cause** — What assumption or action caused the failure?

2. **Distill to one sentence:**
   - Start with "Always..." or "Never..."
   - Be specific about the context
   - Name the actual constraint, not the symptom

3. **Determine scope — local or global?**

   | Signal | Scope |
   |--------|-------|
   | Mentions "this codebase/repo/project" | Local |
   | References project-specific tools/files/patterns | Local |
   | Universal lesson (applies anywhere) | Global |

   **Local:** `./CLAUDE.md` (project root)
   **Global:** `~/.claude/CLAUDE.md`

   When in doubt, propose both options to user.

4. **Check for duplicates** — Read existing rules in target CLAUDE.md

5. **Append to CLAUDE.md** error rules section

## Rule Format

```markdown
- Always {action} before {other action} when {context}.
- Never {action} when {context}.
```

## Examples

Good:
```markdown
- Always verify unit consistency before comparing values across different measurement scales.
- Never assume API pagination returns consistent ordering without explicit ORDER BY.
- Always check if file handle is closed before attempting to delete the file.
```

Bad:
```markdown
- Be careful with APIs.  (too vague)
- Don't make mistakes.  (not actionable)
- Remember the pagination bug from March 15.  (not transferable)
```

## Quality Checks

Before saving, verify:
- [ ] **One sentence** — If you need two, you haven't distilled enough
- [ ] **Starts with Always/Never** — Forces concrete constraint
- [ ] **Context-specific** — Names when this applies
- [ ] **Not a duplicate** — Check existing rules

## The Constraint

Error rules are **mandatory**. They live in CLAUDE.md and are injected into every conversation. They cannot be skipped or ignored. This is the key difference from insights.

- **Global rules** (`~/.claude/CLAUDE.md`) — enforced in all projects
- **Local rules** (`./CLAUDE.md`) — enforced only in this project

Only save rules that are worth enforcing at their chosen scope.
