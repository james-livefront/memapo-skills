#!/bin/bash
# SessionStart hook: Inject library index for automatic insight retrieval
# Install: Add to ~/.claude/settings.json under hooks.SessionStart

INDEX_FILE="$HOME/.claude/library/INDEX.md"

if [[ -f "$INDEX_FILE" ]]; then
    echo "<library-index>"
    echo "Accumulated insights from past sessions. Use as guidance (not mandatory like error rules)."
    echo ""
    cat "$INDEX_FILE"
    echo "</library-index>"
fi
