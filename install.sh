#!/usr/bin/env bash
# One-line automated installer for Masri Systems Portable Agent Hub on macOS/Linux.
set -e

REPO_URL="https://github.com/masrisystems/dot-agents.git"
TARGET_DIR="$HOME/.agents"

echo "=========================================================="
echo "   Masri Systems Portable Multi-Agent Hub Installer       "
echo "=========================================================="

if ! command -v git &> /dev/null; then
    echo "Error: git is required but not installed." >&2
    exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "Cloning agent hub into $TARGET_DIR..."
    git clone "$REPO_URL" "$TARGET_DIR"
else
    echo "Directory $TARGET_DIR exists. Pulling latest..."
    cd "$TARGET_DIR" && git pull origin main --ff-only
fi

# Ensure target directories exist for Claude & Codex
mkdir -p "$HOME/.claude/skills"
mkdir -p "$HOME/.codex"

# Symlink skills for Claude Code
if [ -d "$TARGET_DIR/skills" ]; then
    for skill in "$TARGET_DIR/skills"/*; do
        if [ -d "$skill" ]; then
            name=$(basename "$skill")
            ln -sfn "$skill" "$HOME/.claude/skills/$name"
        fi
    done
fi

echo ""
echo "✓ Installation complete! Agent hub is linked to ~/.claude/skills."
echo "  Canonical Directory: $TARGET_DIR"
