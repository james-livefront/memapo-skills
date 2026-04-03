# MemAPO Skills

Memory system for Claude Code. Accumulate knowledge across sessions.

Inspired by [MemAPO](https://arxiv.org/abs/2501.xxxxx) and the [Epoch AI evaluation framework](https://epoch.ai/).

## Core Concept

Three types of knowledge, three storage locations:

| Type | Storage | Retrieval | Enforcement |
|------|---------|-----------|-------------|
| Error rules | `~/.claude/CLAUDE.md` | Automatic (always present) | Mandatory |
| Insights | `~/.claude/library/*.md` | Via `/recall` skill | Guidance |
| Patterns | Embedded in skills | When skill invoked | Guidance |

## Skills

| Skill | Purpose |
|-------|---------|
| `/post-mortem` | Full retrospective after significant effort |
| `/recall` | Search library for relevant knowledge |
| `/learn` | Quick capture of insight to library |
| `/error-rule` | Quick capture of constraint to CLAUDE.md |

## How It Works

```
                         RECORDING
                            │
          ┌─────────────────┼─────────────────┐
          ▼                 ▼                 ▼
    /post-mortem        /learn          /error-rule
    (full retro)     (quick insight)   (quick constraint)
          │                 │                 │
          └────────┬────────┴────────┬────────┘
                   ▼                 ▼
            Routes to:          Routes to:
                   │                 │
    ┌──────────────┼──────────────┐  │
    ▼              ▼              ▼  ▼
 Library        Skills        CLAUDE.md
 (insights)    (patterns)    (error rules)


                        RETRIEVAL
                            │
          ┌─────────────────┼─────────────────┐
          ▼                 ▼                 ▼
      /recall          Invoke skill      Automatic
          │                 │                 │
          ▼                 ▼                 ▼
   Search library     Patterns in       Error rules
   return relevant    skill appear      always present
```

## Installation

1. Copy skills to your Claude Code skills directory:
   ```bash
   cp -r skills/* ~/.claude/skills/
   ```

2. Add error rules section to your CLAUDE.md:
   ```bash
   cat install/claude-md-section.md >> ~/.claude/CLAUDE.md
   ```

3. Create library directory with starter topics:
   ```bash
   mkdir -p ~/.claude/library
   cp templates/library/*.md ~/.claude/library/
   ```

4. Create temp directory for reports:
   ```bash
   mkdir -p ~/.claude/temp
   ```

   Optional: add cleanup cron (e.g., delete reports older than 7 days):
   ```bash
   # Add to crontab -e
   0 0 * * * find ~/.claude/temp -name "post-mortem-*.md" -mtime +7 -delete
   ```

## Usage

**After significant session:**
```
/post-mortem
```

**Quick insight capture:**
```
/learn
```

**Quick constraint capture:**
```
/error-rule
```

**At task start (retrieve knowledge):**
```
/recall
```

## Library Structure

```
~/.claude/library/
  INDEX.md         # One-liner per insight, scan this first
  testing.md       # Full entries with context
  apis.md          # API integration learnings
  debugging.md     # Debugging insights
  skill-design.md  # Skill creation patterns
  {topic}.md       # Add new topics as needed
```

INDEX.md enables fast scanning - `/recall` reads this first, then dives into topic files for details.

Extensible to slipbox/Zettelkasten patterns later (atomic notes, linking, structure notes).

## The Key Insight

From MemAPO: not all knowledge is equal.

- **Error rules** are mandatory constraints - "Never do X"
- **Insights** are accumulated knowledge - "X tends to cause Y"
- **Patterns** are reusable techniques - "When facing X, try Y then Z"

Each needs different storage and retrieval:
- Error rules: always visible (CLAUDE.md)
- Insights: searched when relevant (/recall)
- Patterns: present when skill invoked
