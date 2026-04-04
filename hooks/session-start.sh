#!/bin/bash
# MemAPO SessionStart hook
# 1. Initialize library directory if needed
# 2. Inject INDEX.md for automatic insight retrieval

LIBRARY_DIR="$HOME/.claude/library"
TEMP_DIR="$HOME/.claude/temp"
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
TEMPLATES_DIR="$PLUGIN_ROOT/templates/library"

# Initialize library if it doesn't exist
if [[ ! -d "$LIBRARY_DIR" ]]; then
    mkdir -p "$LIBRARY_DIR"
    if [[ -d "$TEMPLATES_DIR" ]]; then
        cp "$TEMPLATES_DIR"/*.md "$LIBRARY_DIR/" 2>/dev/null
    fi
fi

# Create temp directory for reports
mkdir -p "$TEMP_DIR"

# Inject INDEX.md if it exists
INDEX_FILE="$LIBRARY_DIR/INDEX.md"
if [[ -f "$INDEX_FILE" ]]; then
    echo "<library-index>"
    echo "Accumulated insights from past sessions. Use as guidance (not mandatory like error rules)."
    echo ""
    cat "$INDEX_FILE"
    echo "</library-index>"
fi
