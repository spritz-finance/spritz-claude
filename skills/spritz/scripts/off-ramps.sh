#!/usr/bin/env bash
# Spritz Off-Ramps — list off-ramp transactions
# Usage: off-ramps.sh <command> [args...]
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib.sh"

# ─── list — list off-ramp transactions
cmd_list() {
  local query=""
  [ -n "${STATUS:-}" ]     && query="${query:+$query&}status=$STATUS"
  [ -n "${CHAIN:-}" ]      && query="${query:+$query&}chain=$CHAIN"
  [ -n "${ACCOUNT_ID:-}" ] && query="${query:+$query&}accountId=$ACCOUNT_ID"
  [ -n "${LIMIT:-}" ]      && query="${query:+$query&}limit=$LIMIT"
  [ -n "${CURSOR:-}" ]     && query="${query:+$query&}cursor=$CURSOR"
  [ -n "${SORT:-}" ]       && query="${query:+$query&}sort=$SORT"

  local url="$BASE_URL/v1/off-ramps/"
  [ -n "$query" ] && url="$url?$query"
  spritz_get "$url"
}

# ─── dispatch ─────────────────────────────────────────────────────────────────
case "${1:-}" in
  list) shift; cmd_list "$@" ;;
  *)
    echo "Usage: $(basename "$0") <command> [args...]"
    echo ""
    echo "Commands:"
    echo "  list    List off-ramp transactions"
    echo ""
    echo "Environment variables for list:"
    echo "  STATUS      Filter: awaiting_funding|queued|in_flight|completed|canceled|failed|reversed|refunded"
    echo "  CHAIN       Filter by chain (ethereum, base, polygon, ...)"
    echo "  ACCOUNT_ID  Filter by destination account ID"
    echo "  LIMIT       Max results (1-100, default 50)"
    echo "  CURSOR      Pagination cursor from previous response"
    echo "  SORT        Sort order: asc|desc"
    exit 1
    ;;
esac
