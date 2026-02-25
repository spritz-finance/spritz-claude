# Spritz Plugin for Claude Code

Off-ramp crypto to fiat bank accounts using Spritz Finance MCP tools.

## Installation

```bash
/plugin marketplace add spritz-finance/spritz-claude
/plugin install spritz@spritz-finance/spritz-claude
```

Restart Claude Code after installing. The MCP server starts automatically.

## Setup

Store your Spritz API key so the MCP server can authenticate:

```bash
/spritz:spritz setup <YOUR_API_KEY>
```

Or manually:

```bash
mkdir -p ~/.config/spritz && echo -n 'YOUR_KEY' > ~/.config/spritz/api_key && chmod 600 ~/.config/spritz/api_key
```

Restart Claude Code after setup.

Get an API key from the [Spritz dashboard](https://app.spritz.finance).

## Updating

```bash
claude plugin update spritz@spritz-finance/spritz-claude
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
