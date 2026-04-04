#!/bin/bash
# MemAPO SessionStart hook
# 1. Initialize global library directory if needed
# 2. Inject both global and local INDEX.md for automatic insight retrieval

GLOBAL_LIBRARY_DIR="$HOME/.claude/library"
LOCAL_LIBRARY_DIR="./.claude/library"
TEMP_DIR="$HOME/.claude/temp"
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
TEMPLATES_DIR="$PLUGIN_ROOT/templates/library"

# Initialize global library if it doesn't exist
if [[ ! -d "$GLOBAL_LIBRARY_DIR" ]]; then
    mkdir -p "$GLOBAL_LIBRARY_DIR"
    if [[ -d "$TEMPLATES_DIR" ]]; then
        cp "$TEMPLATES_DIR"/*.md "$GLOBAL_LIBRARY_DIR/" 2>/dev/null
    fi
fi

# Create temp directory for reports
mkdir -p "$TEMP_DIR"

# Inject global INDEX.md if it exists
GLOBAL_INDEX="$GLOBAL_LIBRARY_DIR/INDEX.md"
if [[ -f "$GLOBAL_INDEX" ]]; then
    echo "<library-index scope=\"global\">"
    echo "Global insights (apply everywhere). Use as guidance."
    echo ""
    cat "$GLOBAL_INDEX"
    echo "</library-index>"
fi

# Inject local INDEX.md if it exists (project-specific)
LOCAL_INDEX="$LOCAL_LIBRARY_DIR/INDEX.md"
if [[ -f "$LOCAL_INDEX" ]]; then
    echo ""
    echo "<library-index scope=\"local\">"
    echo "Project-specific insights. Use as guidance for this codebase."
    echo ""
    cat "$LOCAL_INDEX"
    echo "</library-index>"
fi
