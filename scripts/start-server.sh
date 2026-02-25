#!/usr/bin/env bash
# Wrapper that loads the API key from ~/.config/spritz/api_key and starts the MCP server.

KEY_FILE="$HOME/.config/spritz/api_key"

if [ -z "${SPRITZ_API_KEY:-}" ] && [ -f "$KEY_FILE" ]; then
  export SPRITZ_API_KEY="$(cat "$KEY_FILE")"
fi

exec npx -y @spritz-finance/mcp-server "$@"
