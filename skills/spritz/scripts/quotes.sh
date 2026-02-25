#!/usr/bin/env bash
# Spritz Off-Ramp Quotes — create and manage off-ramp quotes
# Usage: quotes.sh <command> [args...]
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib.sh"

# ─── create — create an off-ramp quote
cmd_create() {
  if [ -z "$1" ]; then
    echo "Usage: quotes.sh create <json_body>"
    echo ""
    echo "  Required: accountId, amount, chain"
    echo "  Optional: amountMode (output|input), tokenAddress, rail, memo"
    echo ""
    echo "  Chains: ethereum, polygon, arbitrum, base, optimism, avalanche,"
    echo "          binance-smart-chain, solana, bitcoin, tron, sui, and more"
    echo ""
    echo "  Rails: ach_standard, rtp, wire, eft, sepa, push_to_debit, bill_pay"
    echo ""
    echo "  Example:"
    echo '    quotes.sh create '\''{"accountId":"abc123","amount":"100.00","chain":"base","tokenAddress":"0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48"}'\'''
    return 1
  fi
  spritz_post "$BASE_URL/v1/off-ramp-quotes/" "$1"
}

# ─── get — get a quote by ID
cmd_get() {
  if [ -z "${1:-}" ]; then
    echo "Usage: quotes.sh get <quoteId>"
    return 1
  fi
  spritz_get "$BASE_URL/v1/off-ramp-quotes/$1"
}

# ─── transaction — get transaction params to sign and submit on-chain
cmd_transaction() {
  if [ -z "${1:-}" ] || [ -z "${2:-}" ]; then
    echo "Usage: quotes.sh transaction <quoteId> <json_body>"
    echo ""
    echo "  Required: senderAddress (wallet address signing the tx)"
    echo "  Optional: feePayer (Solana only, defaults to senderAddress)"
    echo ""
    echo "  Returns EVM calldata (contractAddress, calldata, value)"
    echo "  or serialized Solana transaction (transactionSerialized)."
    echo ""
    echo "  Example:"
    echo '    quotes.sh transaction quote_abc123 '\''{"senderAddress":"0x742d35Cc6634C0532925a3b844Bc9e7595f2bD18"}'\'''
    return 1
  fi
  spritz_post "$BASE_URL/v1/off-ramp-quotes/$1/transaction" "$2"
}

# ─── dispatch ─────────────────────────────────────────────────────────────────
case "${1:-}" in
  create)      shift; cmd_create "$@" ;;
  get)         shift; cmd_get "$@" ;;
  transaction) shift; cmd_transaction "$@" ;;
  *)
    echo "Usage: $(basename "$0") <command> [args...]"
    echo ""
    echo "Commands:"
    echo "  create <json>                 Create an off-ramp quote"
    echo "  get <quoteId>                 Get quote details/status"
    echo "  transaction <quoteId> <json>  Get on-chain transaction params"
    exit 1
    ;;
esac
