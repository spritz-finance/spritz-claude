#!/usr/bin/env bash
# Spritz Bank Accounts — manage off-ramp destinations
# Usage: bank-accounts.sh <command> [args...]
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib.sh"

# ─── list — list all saved bank accounts
cmd_list() {
  spritz_get "$BASE_URL/v1/bank-accounts/"
}

# ─── create — add a new bank account
cmd_create() {
  if [ -z "$1" ]; then
    echo "Usage: bank-accounts.sh create <json_body>"
    echo ""
    echo "  Type determines required fields:"
    echo "    us:   routingNumber (9-digit), accountNumber, accountSubtype (checking|savings)"
    echo "    ca:   institutionNumber (3-digit), transitNumber (5-digit), accountNumber"
    echo "    uk:   sortCode (6-digit), accountNumber"
    echo "    iban: iban, optional bic"
    echo ""
    echo "  Always required: type (us|ca|uk|iban), ownership (personal|thirdParty)"
    echo "  Optional: label, accountHolder (required if ownership=thirdParty)"
    echo ""
    echo "  Example:"
    echo '    bank-accounts.sh create '\''{"type":"us","ownership":"personal","routingNumber":"021000021","accountNumber":"123456789","accountSubtype":"checking","label":"Primary Checking"}'\'''
    return 1
  fi
  spritz_post "$BASE_URL/v1/bank-accounts/" "$1"
}

# ─── delete — remove a bank account by ID
cmd_delete() {
  if [ -z "${1:-}" ]; then
    echo "Usage: bank-accounts.sh delete <accountId>"
    return 1
  fi
  spritz_delete "$BASE_URL/v1/bank-accounts/$1"
}

# ─── dispatch ─────────────────────────────────────────────────────────────────
case "${1:-}" in
  list)   shift; cmd_list "$@" ;;
  create) shift; cmd_create "$@" ;;
  delete) shift; cmd_delete "$@" ;;
  *)
    echo "Usage: $(basename "$0") <command> [args...]"
    echo ""
    echo "Commands:"
    echo "  list              List all bank accounts"
    echo "  create <json>     Add a new bank account"
    echo "  delete <id>       Delete a bank account"
    exit 1
    ;;
esac
