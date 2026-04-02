---
name: recall
description: Use at task start or when stuck to retrieve relevant knowledge from the library - searches accumulated insights across all topics.
---

# Recall

Search the knowledge library for insights relevant to the current task.

## When to Use

- Starting a non-trivial task
- Stuck on a problem and want to check past learnings
- Before implementing something you've done before
- When the task touches a domain where you've accumulated knowledge

## Process

1. **Identify the task context** - What domain? What problem type?

2. **List library topics:**
   ```
   ls ~/.claude/library/
   ```

3. **Read relevant topic files** - Select 1-3 most relevant based on task

4. **Extract applicable insights** - Scan for entries that apply to current context

5. **Inject as context:**
   ```
   <library>
   From testing.md:
   - setTimeout in tests causes flakiness; use waitFor or explicit conditions
   - Test rejection cases before acceptance cases for validation logic

   From apis.md:
   - Pagination endpoints don't guarantee ordering without explicit ORDER BY
   </library>
   ```

6. **Proceed with task** - Use insights as guidance (not mandatory like error rules)

## Library Structure

```
~/.claude/library/
  testing.md       # Testing patterns, gotchas, techniques
  apis.md          # API integration learnings
  debugging.md     # Debugging insights
  performance.md   # Performance observations
  {topic}.md       # Extensible by domain
```

## Entry Format

Each insight in a library file:

```markdown
## {Short title}

{One paragraph or less. What's the insight?}

Context: {When does this apply?}
Source: {Where did this come from? Optional.}
```

Or simpler, just bullets:

```markdown
# Testing

- setTimeout in tests causes flakiness; use waitFor or explicit conditions
- Test rejection cases before acceptance cases for validation logic
- Mocking at the network layer is more stable than mocking internal functions
```

## Relationship to Error Rules

| Library insights | Error rules (CLAUDE.md) |
|------------------|-------------------------|
| Retrieved when relevant | Always present |
| Guidance | Mandatory |
| Can be ignored | Cannot be skipped |
| Searched via /recall | Automatic injection |

If an insight is critical enough that it must ALWAYS be followed, it should be an error rule in CLAUDE.md, not a library entry.

## Future: Slipbox Integration

The library structure supports evolution to Zettelkasten patterns:
- Atomic notes with IDs
- Linking between insights
- Structure notes for topics
- Tags and metadata

For now, keep it simple: topic files with bullet points or short entries.
