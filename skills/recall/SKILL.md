---
name: recall
description: Use when you need full context from library topic files - deep dive into insights beyond the auto-injected INDEX.md summaries.
---

# Recall

Deep dive into knowledge library for full context on relevant insights.

## When to Use

Note: INDEX.md is auto-injected at session start via hook. You already have the one-liners.

Use /recall when you need:
- Full entry context (not just the one-liner)
- Pattern details or examples from a topic file
- To explore related insights in a topic area

## Process

1. **Check which topic applies** - INDEX.md (already visible) shows topics

2. **Read the topic file:**
   ```
   ~/.claude/library/{topic}.md
   ```

3. **Extract full entries** - Get context, patterns, examples

4. **Apply to current task** - Use as guidance (not mandatory like error rules)

## Library Structure

```
~/.claude/library/
  INDEX.md         # One-liner per insight, scan this first
  skill-design.md  # Full entries with context
  testing.md       # Testing patterns, gotchas
  apis.md          # API integration learnings
  debugging.md     # Debugging insights
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

## Retrieval Comparison

| Type | Injection | Enforcement | Depth |
|------|-----------|-------------|-------|
| Error rules | Automatic (CLAUDE.md) | Mandatory | Full text |
| Insights | Automatic (INDEX.md) | Guidance | One-liners |
| Topic details | Via /recall | Guidance | Full entries |

If an insight is critical enough that it must ALWAYS be followed, it should be an error rule in CLAUDE.md, not a library entry.

## Future: Slipbox Integration

The library structure supports evolution to Zettelkasten patterns:
- Atomic notes with IDs
- Linking between insights
- Structure notes for topics
- Tags and metadata

For now, keep it simple: topic files with bullet points or short entries.
