#!/usr/bin/env bash
# Restores Claude Code marketplaces and user-scope plugins from config/plugins.json.
set -e

MANIFEST="$(dirname "$0")/../config/plugins.json"

if ! command -v claude &> /dev/null; then
    echo "Claude Code CLI not found in PATH. Skipping plugin restore." >&2
    exit 0
fi
if [ ! -f "$MANIFEST" ]; then
    echo "No plugin manifest at $MANIFEST. Skipping." >&2
    exit 0
fi
if ! command -v node &> /dev/null; then
    echo "node is required to parse the manifest. Skipping." >&2
    exit 0
fi

read_json() { node -e "const d=require('$MANIFEST');console.log($1)"; }

for repo in $(read_json "Object.values(d.marketplaces).join('\n')"); do
    echo "Adding marketplace $repo..."
    claude plugin marketplace add "$repo"
done

for plugin in $(read_json "d.plugins.join('\n')"); do
    echo "Installing $plugin..."
    claude plugin install "$plugin"
done

echo "Plugin restore complete."
