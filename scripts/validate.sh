#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

jq empty \
  "$repo_root/.claude-plugin/marketplace.json" \
  "$repo_root/.claude-plugin/plugin.json" \
  "$repo_root/.mcp.json"

while IFS= read -r script; do
  bash -n "$script"
done < <(find "$repo_root" -type f -name '*.sh' -not -path '*/.git/*' | sort)

grep -Fq 'exec spritz auth mcp --access user' "$repo_root/scripts/start-server.sh"
grep -Fq 'spritz auth device start --access user' "$repo_root/README.md"
grep -Fq 'spritz auth mcp --access developer' "$repo_root/README.md"

echo "Spritz Claude plugin validation passed."
