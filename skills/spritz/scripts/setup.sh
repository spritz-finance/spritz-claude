#!/usr/bin/env bash
set -euo pipefail

# Store Spritz API key and configure the MCP server for Claude Code.
#
# Usage:
#   bash setup.sh <API_KEY>
#   bash setup.sh --file /path/to/keyfile
#   SPRITZ_API_KEY=sk_... bash setup.sh

SPRITZ_CONFIG_DIR="$HOME/.config/spritz"
SPRITZ_KEY_PATH="$SPRITZ_CONFIG_DIR/api_key"
CLAUDE_MCP_CONFIG="$HOME/.claude/.mcp.json"

# --- Resolve API key ---

API_KEY=""

if [[ "${1:-}" == "--file" ]]; then
  if [[ -z "${2:-}" || ! -f "$2" ]]; then
    echo "Error: --file requires a valid file path" >&2
    exit 1
  fi
  API_KEY="$(cat "$2" | tr -d '[:space:]')"
elif [[ -n "${1:-}" ]]; then
  API_KEY="$1"
elif [[ -n "${SPRITZ_API_KEY:-}" ]]; then
  API_KEY="$SPRITZ_API_KEY"
else
  echo "Usage: bash setup.sh <API_KEY>" >&2
  echo "       bash setup.sh --file /path/to/keyfile" >&2
  echo "       SPRITZ_API_KEY=sk_... bash setup.sh" >&2
  exit 1
fi

if [[ -z "$API_KEY" ]]; then
  echo "Error: API key is empty" >&2
  exit 1
fi

# --- Store API key ---

mkdir -p "$SPRITZ_CONFIG_DIR"
printf '%s' "$API_KEY" > "$SPRITZ_KEY_PATH"
chmod 600 "$SPRITZ_KEY_PATH"
echo "Stored API key at $SPRITZ_KEY_PATH"

# --- Configure MCP server in ~/.claude/.mcp.json ---

mkdir -p "$(dirname "$CLAUDE_MCP_CONFIG")"

if [[ ! -f "$CLAUDE_MCP_CONFIG" ]]; then
  echo '{}' > "$CLAUDE_MCP_CONFIG"
fi

# Build the spritz MCP server entry
SPRITZ_MCP_ENTRY=$(cat <<'ENTRY'
{
  "command": "npx",
  "args": ["-y", "@spritz-finance/mcp-server"],
  "env": {
    "SPRITZ_API_KEY": "__API_KEY__"
  }
}
ENTRY
)
SPRITZ_MCP_ENTRY="${SPRITZ_MCP_ENTRY//__API_KEY__/$API_KEY}"

# Check for jq
if ! command -v jq &>/dev/null; then
  echo "Warning: jq not found. Writing config manually." >&2
  # If the file is empty or just {}, write fresh
  if [[ ! -s "$CLAUDE_MCP_CONFIG" ]] || [[ "$(cat "$CLAUDE_MCP_CONFIG" | tr -d '[:space:]')" == "{}" ]]; then
    cat > "$CLAUDE_MCP_CONFIG" <<EOF
{
  "mcpServers": {
    "spritz": {
      "command": "npx",
      "args": ["-y", "@spritz-finance/mcp-server"],
      "env": {
        "SPRITZ_API_KEY": "$API_KEY"
      }
    }
  }
}
EOF
    echo "Created $CLAUDE_MCP_CONFIG with spritz MCP server"
  else
    echo "Error: Cannot merge into existing config without jq. Please install jq." >&2
    exit 1
  fi
else
  # Use jq to merge
  UPDATED=$(jq --argjson entry "$SPRITZ_MCP_ENTRY" \
    '.mcpServers.spritz = $entry' \
    "$CLAUDE_MCP_CONFIG")
  printf '%s\n' "$UPDATED" > "$CLAUDE_MCP_CONFIG"
  echo "Added spritz MCP server to $CLAUDE_MCP_CONFIG"
fi

echo ""
echo "Setup complete. Restart Claude Code to activate the Spritz MCP server."
