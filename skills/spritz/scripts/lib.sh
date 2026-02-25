#!/usr/bin/env bash
# Shared library for Spritz API scripts
# Source this file: source "$(dirname "$0")/lib.sh"

BASE_URL="https://platform.spritz.finance"

spritz_auth() {
  if [ -n "${SPRITZ_API_KEY:-}" ]; then
    SPRITZ_KEY="$SPRITZ_API_KEY"
  else
    SPRITZ_KEY=$(cat ~/.config/spritz/api_key 2>/dev/null || echo "")
  fi
  if [ -z "$SPRITZ_KEY" ]; then
    echo "Error: No API key found. Set SPRITZ_API_KEY env variable or run: echo 'your-key' > ~/.config/spritz/api_key"
    exit 1
  fi
  export SPRITZ_KEY
}

# Generic curl wrapper: spritz_curl METHOD URL [DATA]
spritz_curl() {
  local method="$1" url="$2" data="${3:-}"
  local args=(-s -w '\n__HTTP_STATUS:%{http_code}' -X "$method" "$url" \
    -H "Authorization: Bearer $SPRITZ_KEY" \
    -H "Content-Type: application/json")
  if [ -n "$data" ]; then
    args+=(-d "$data")
  fi
  local response
  response=$(curl "${args[@]}" 2>&1)
  local http_status="${response##*__HTTP_STATUS:}"
  local body="${response%__HTTP_STATUS:*}"
  if echo "$body" | jq '.' >/dev/null 2>&1; then
    echo "$body"
  else
    jq -n --arg msg "$body" --arg code "$http_status" '{error: $msg, http_status: ($code | tonumber)}'
  fi
}

spritz_get()    { spritz_curl GET    "$1" | jq '.'; }
spritz_post()   { spritz_curl POST   "$1" "$2" | jq '.'; }
spritz_delete() { spritz_curl DELETE "$1" | jq '.'; }

# Auto-init auth on source
spritz_auth
