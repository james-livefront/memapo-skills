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

**Output:** The full report (Phases 1-4) is always generated and shown. Phase 5 then asks what to persist - the report itself is valuable even if nothing is saved.

---

## Arguments

$ARGUMENTS: Optional scope - path, feature name, or "session" (default: current session).

---

## Phase 1: Outcome Assessment

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

**Present the full report (Phases 1-4) to the user first.** Then ask:

> "What would you like to do with these insights?"

Options:

- [ ] **Save insight to library** → Append to `~/.claude/library/{topic}.md`
- [ ] **Add pattern to a skill** → Edit `~/.claude/skills/{skill}/SKILL.md`
- [ ] **Save as error rule** → Append to `~/.claude/CLAUDE.md` error rules section
- [ ] **Just the report** → No persistence, conversation record is enough

Multiple selections allowed. If any persistence option is selected, execute immediately.

### Routing Guide

| What you learned | Where it goes | Format |
|------------------|---------------|--------|
| Fact, principle, observation | Library (`~/.claude/library/{topic}.md`) | Bullet point or short entry |
| Reusable technique with steps | Skill's patterns section | When/steps/example |
| "Never do X again" constraint | CLAUDE.md error rules | `- Always/Never {action} when {context}.` |
| Just want the analysis | Nowhere | Report visible in conversation |

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
