---
name: post-mortem
description: Use after significant effort - debugging sessions, feature implementations, research deep-dives, failed deploys, or when the user says "retro", "post-mortem", or "what did we learn".
---

# Meta: Post-Mortem

> Extract reusable knowledge from any completed effort - success or failure. Inspired by Epoch AI's frontier model evaluation framework.

## Triggers

Use after:
- A long debugging session (resolved or abandoned)
- A complex feature implementation
- A research deep-dive that hit dead ends
- A failed deployment or rollback
- Any task where you spent significant effort
- When the user says "what did we learn", "retro", "post-mortem", "debrief"

Do NOT use for trivial tasks (single-file edits, quick fixes).

**Output:** The full report (Phases 1-4) is always generated, shown, and saved to:
```
~/.claude/temp/post-mortem-{YYYY-MM-DD}-{slug}.md
```

This temp file will be cleaned up eventually - the report is for short-term reference. Phase 5 distills what's worth persisting long-term (insights, patterns, error rules).

---

## Arguments

$ARGUMENTS: Optional scope - path, feature name, or "session" (default: current session).

---

## Phase 1: Outcome Assessment

**Start by creating the report file:**
```
~/.claude/temp/post-mortem-{YYYY-MM-DD}-{slug}.md
```

State the outcome plainly. No spin.

```
Outcome: SUCCESS | PARTIAL | FAILURE | ABANDONED
Goal: {what was the objective}
Result: {what actually happened}
Effort: {rough magnitude - minutes, hours, session count}
```

---

## Phase 2: The Four Questions

Answer each. Evidence required - no handwaving.

### Q1: What did you try?

Chronological list of approaches. Be specific about what each approach *was*, not what it *hoped to do*.

| # | Approach | Tools/Methods Used | Result |
|---|----------|--------------------|--------|
| 1 | {specific approach} | {what tools, libs, techniques} | worked / partial / failed |
| 2 | ... | ... | ... |

### Q2: What worked and why?

For each successful approach:
- **What**: the specific technique
- **Why it worked**: the structural reason (not "I got lucky")
- **When to reuse**: what class of problems benefits from this

### Q3: What didn't work and why?

For each failed approach:
- **What**: the specific technique
- **Why it failed**: root cause (wrong model of the problem? wrong tool? wrong assumption?)
- **Signal you should have caught**: what would have told you earlier this was a dead end?
- **Lesson**: one sentence, transferable

### Q4: What would help someone facing a similar problem?

Write as if briefing a colleague who will face this problem tomorrow. No fluff.

- Key insight they should start with (skip the dead ends)
- The right mental model for this class of problem
- Tools or techniques that made the difference
- Common traps to avoid

---

## Phase 3: Distill Three Insights

The most important output. Exactly 3 reusable structural insights.

Rules:
- Each must be **transferable** - useful beyond this specific problem
- Each must be **specific** - not "tests are useful" but "testing the inverse constraint caught 3 bugs the direct approach missed"
- Each must be **surprising** - something you didn't know before this session

Format:
```
1. **{Insight name}.**
   {One sentence explaining the principle.}
   Applies to: {what class of problems}

2. **{Insight name}.**
   {One sentence.}
   Applies to: {what class of problems}

3. **{Insight name}.**
   {One sentence.}
   Applies to: {what class of problems}
```

---

## Phase 4: Reformulation Log

Did the problem get reframed during the effort? This is often where breakthroughs hide.

| Stage | How I Framed the Problem | What Triggered the Reframe |
|-------|-------------------------|---------------------------|
| Start | {initial understanding} | - |
| After attempt #{n} | {new framing} | {what observation forced it} |
| Final | {how I think about it now} | {the key shift} |

If no reframe happened, say so - and consider whether one was needed.

---

## Phase 5: Memory Decision

**After presenting the report (Phases 1-4), confirm the file location:**

> "Report saved to `~/.claude/temp/post-mortem-{date}-{slug}.md`"

**Then propose what to persist:**

> "Based on this, I'd suggest:
> - Saving '{insight}' to library/debugging.md
> - Adding '{pattern}' to the testing skill
> - Recording '{constraint}' as an error rule
>
> Does this look right?"

### The Flow

```
1. Analyze insights from Phases 1-4
2. Propose specific persistence actions (can be multiple)
3. If user agrees → execute all
4. If user disagrees → ask what they'd prefer
5. If user says "just the report" → done, no persistence
```

### Routing Guide

| What you learned | Where it goes | Format |
|------------------|---------------|--------|
| Fact, principle, observation | Library: `INDEX.md` + `{topic}.md` | One-liner in index, full entry in topic |
| Reusable technique with steps | Skill's patterns section | When/steps/example |
| "Never do X again" constraint | CLAUDE.md error rules | `- Always/Never {action} when {context}.` |
| Nothing worth persisting | Nowhere | Report visible in conversation |

### Local vs Global Scope

For insights and error rules, determine scope:

| Signal | Scope | Location |
|--------|-------|----------|
| About this codebase specifically | Local | `./.claude/library/` or `./CLAUDE.md` |
| Project-specific tools/patterns | Local | `./.claude/library/` or `./CLAUDE.md` |
| Universal lesson (applies anywhere) | Global | `~/.claude/library/` or `~/.claude/CLAUDE.md` |

When proposing persistence, include the scope:
> "Saving '{insight}' to **global** library/debugging.md"
> "Recording '{constraint}' as a **local** error rule (this project only)"

### Multiple Outputs

A single post-mortem can produce several persistence actions:
- 1 error rule + 2 library insights + 1 pattern → all valid
- Propose all at once, execute all if approved

---

## Rules

1. **Honesty over completeness** - "I don't know why this worked" is valid
2. **No credit-taking** - Don't celebrate success, extract knowledge from it
3. **No blame** - Dead ends are data, not failures
4. **Specificity** - "Changed the recursion from binary to 4-way split" not "improved the algorithm"
5. **Transferability** - Every insight must name the class of problems it applies to
6. **Brevity** - One sentence per insight. If you need two, you haven't distilled enough
7. **Both paths** - Document what worked AND what didn't. The dead ends are half the value.

---

## Anti-Patterns

- "Overall the session went well" - useless, extract what specifically went well
- Listing 10 minor observations instead of 3 structural insights - distill harder
- "I should have tried X" without explaining why X would have worked - hindsight bias
- Treating success as "nothing to learn" - success hides inefficiency
- Skipping the reformulation log - reframes are the highest-value knowledge
