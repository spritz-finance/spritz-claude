# Spritz Plugin for Claude Code

Off-ramp crypto to fiat bank accounts using Spritz Finance MCP tools.

## Installation

```bash
/install spritz
```

Or manually:

```bash
/plugin marketplace add spritz-finance/spritz-plugin
/plugin install spritz@spritz-finance/spritz-plugin
```

## Setup

Run the setup script with your Spritz API key:

```bash
bash scripts/setup.sh <YOUR_API_KEY>
```

This will:
1. Store your API key at `~/.config/spritz/api_key`
2. Add the Spritz MCP server to `~/.claude/.mcp.json`

Restart Claude Code after setup.

### Get an API Key

Create one in the [Spritz dashboard](https://app.spritz.finance).

## What's Included

### MCP Tools (via `@spritz-finance/mcp-server`)

| Tool | Description |
|------|-------------|
| `list_bank_accounts` | List saved bank account destinations |
| `create_bank_account` | Add a new bank account (US, CA, UK, IBAN) |
| `delete_bank_account` | Delete a bank account by ID |
| `create_off_ramp_quote` | Create a crypto-to-fiat quote |
| `get_off_ramp_quote` | Check quote status |
| `get_off_ramp_transaction` | Get on-chain transaction params for a quote |
| `list_off_ramps` | List off-ramp transactions |

### Skill

The `spritz` skill provides Claude with the full workflow guide, supported networks/tokens, bank account types, and security rules.

## Prerequisites

- **Spritz API key**
- **Crypto wallet** — the agent must have its own wallet for signing transactions
- **Node.js >= 18** — for `npx @spritz-finance/mcp-server`

## License

MIT
