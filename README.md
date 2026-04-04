# MemAPO Skills

Memory system for Claude Code. Accumulate knowledge across sessions.

Inspired by [MemAPO](https://arxiv.org/abs/2501.xxxxx) and the [Epoch AI evaluation framework](https://epoch.ai/).

## Core Concept

Three types of knowledge, two scopes:

| Type | Global | Local (project) | Enforcement |
|------|--------|-----------------|-------------|
| Error rules | `~/.claude/CLAUDE.md` | `./CLAUDE.md` | Mandatory |
| Insights | `~/.claude/library/` | `./.claude/library/` | Guidance |
| Patterns | Embedded in skills | — | Guidance |

**Global** = applies everywhere. **Local** = this project only.

Both global and local INDEX.md files are auto-injected at session start.

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
      Automatic        Invoke skill      Automatic
          │                 │                 │
          ▼                 ▼                 ▼
   INDEX.md injected   Patterns in       Error rules
   at session start    skill appear      always present
          │
          ▼
   /recall for deep
   dives into topics
```

## Installation

### As Plugin (Recommended)

```bash
claude plugin add github:jamesfishwick/memapo-skills
```

This automatically:
- Installs all skills (`/post-mortem`, `/recall`, `/learn`, `/error-rule`)
- Configures SessionStart hook for INDEX.md injection
- Creates `~/.claude/library/` with starter topics on first run
- Creates `~/.claude/temp/` for post-mortem reports

Then add the error rules section to your CLAUDE.md:
```bash
cat ~/.claude/plugins/cache/*/memapo-skills/*/install/claude-md-section.md >> ~/.claude/CLAUDE.md
```

### Manual Installation

If you prefer not to use plugins:

1. Clone the repo and copy skills:
   ```bash
   git clone https://github.com/jamesfishwick/memapo-skills
   cp -r memapo-skills/skills/* ~/.claude/skills/
   ```

2. Set up library and hooks manually (see `install/` directory)

### Optional: Report Cleanup

Add cron job to delete old reports:
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

**Deep dive into topic (full context):**
```
/recall
```
Note: INDEX.md is auto-injected at session start. Use `/recall` when you need full entries from topic files.

## Library Structure

**Global library** (all projects):
```
~/.claude/library/
  INDEX.md         # One-liner per insight
  testing.md       # Topic files with full entries
  apis.md
  debugging.md
  {topic}.md
```

**Local library** (project-specific):
```
./.claude/library/
  INDEX.md         # Project-specific insights
  architecture.md  # How this codebase works
  {topic}.md
```

Both INDEX.md files are auto-injected at session start. Use `/recall` for deep dives into topic files.

Extensible to slipbox/Zettelkasten patterns later (atomic notes, linking, structure notes).

## The Key Insight

From MemAPO: not all knowledge is equal.

- **Error rules** are mandatory constraints - "Never do X"
- **Insights** are accumulated knowledge - "X tends to cause Y"
- **Patterns** are reusable techniques - "When facing X, try Y then Z"

Each needs different storage and retrieval:
- Error rules: always visible (CLAUDE.md) - mandatory
- Insights: auto-injected (INDEX.md) - guidance
- Patterns: present when skill invoked - guidance
