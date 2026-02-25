# Spritz Plugin for Claude Code

Off-ramp crypto to fiat bank accounts using Spritz Finance MCP tools.

## Installation

```bash
/plugin marketplace add spritz-finance/spritz-claude
/plugin install spritz@spritz-claude
```

Restart Claude Code after installing. The MCP server starts automatically.

## Setup

Get your API key from [app.spritz.finance/api-keys](https://app.spritz.finance/api-keys).

Store the key:

```bash
mkdir -p ~/.config/spritz
echo "your-api-key" > ~/.config/spritz/api_key
```

Restart Claude Code to activate.

## Updating

```bash
/plugin marketplace update spritz-claude
/plugin update spritz@spritz-claude
```

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

The `/spritz:spritz` skill provides Claude with the full workflow guide, supported networks/tokens, bank account types, and security rules.

## Prerequisites

- **Spritz API key**
- **Crypto wallet** — the agent must have its own wallet for signing transactions
- **Node.js >= 18** — for `npx @spritz-finance/mcp-server`

## License

MIT
