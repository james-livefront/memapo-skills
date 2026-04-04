---
name: learn
description: Use for quick capture of an insight to the library - when a full post-mortem is overkill but the knowledge should not be lost.
---

# Learn (Quick Capture)

Shortcut for capturing an insight to the library without a full post-mortem.

For significant sessions with multiple insights, use `/post-mortem` instead.

## When to Use

- Discovered something worth remembering mid-task
- User shares knowledge worth preserving
- Found a gotcha that's not critical enough for an error rule
- Learning something new about a domain

## Process

1. **Identify the topic** - Which domain does this belong to?
   ```
   testing, apis, debugging, skill-design, performance, {new-topic}
   ```

2. **Distill to one insight** - What's the core knowledge?

3. **Determine scope — local or global?**

   | Signal | Scope |
   |--------|-------|
   | About this codebase's architecture/patterns | Local |
   | How this project's specific tools work | Local |
   | Universal lesson (applies anywhere) | Global |

   **Local:** `./.claude/library/` (project root)
   **Global:** `~/.claude/library/`

   When in doubt, propose both options to user.

4. **Quality check:**
   - Is this transferable beyond this specific case? (if global)
   - Is it specific enough to be actionable?
   - Is it worth remembering?

5. **Append to both files in chosen library:**
   ```
   {library}/INDEX.md      ← add one-liner under topic heading
   {library}/{topic}.md    ← add full entry if context needed
   ```

6. **Confirm:** "Added to {local|global} library: {one-line summary}"

## Format

Simple bullet:
```markdown
- {Insight in one sentence}
```

Or with context:
```markdown
## {Short title}

{The insight.}

Context: {When this applies}
```

## Examples

Good:
```markdown
- API pagination doesn't guarantee order without explicit ORDER BY in the query
- React useEffect cleanup runs before the next effect, not on unmount only
- Git rebase -i with 'edit' lets you split commits mid-rebase
```

Bad:
```markdown
- APIs are tricky (too vague)
- Remember the bug from Tuesday (not transferable)
- Always use TypeScript (opinion, not insight)
```

## Relationship to Other Skills

| Skill | Use when |
|-------|----------|
| `/learn` | Quick insight capture (this) |
| `/error-rule` | Mandatory constraint ("Never X") |
| `/post-mortem` | Full retrospective with multiple outputs |
| `/recall` | Retrieve knowledge at task start |
