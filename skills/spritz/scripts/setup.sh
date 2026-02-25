#!/usr/bin/env bash
set -euo pipefail

# Store Spritz API key for the MCP server.
# The plugin's .mcp.json handles server config automatically.
#
# Usage:
#   bash setup.sh <API_KEY>
#   bash setup.sh --file /path/to/keyfile
#   SPRITZ_API_KEY=sk_... bash setup.sh

SPRITZ_CONFIG_DIR="$HOME/.config/spritz"
SPRITZ_KEY_PATH="$SPRITZ_CONFIG_DIR/api_key"

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
echo ""
echo "Restart Claude Code to activate the Spritz MCP server."
