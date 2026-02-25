# Spritz — Claude Code Plugin

Off-ramp crypto to fiat bank accounts with AI agents.

## Quick Start

### 1. Install the plugin

```bash
/plugin marketplace add spritz-finance/spritz-claude
/plugin install spritz@spritz-claude
```

### 2. Add your API key

Get a key from [app.spritz.finance/api-keys](https://app.spritz.finance/api-keys), then:

```bash
mkdir -p ~/.config/spritz
echo "your-api-key" > ~/.config/spritz/api_key
```

### 3. Restart Claude Code

The MCP server starts automatically. You're ready to go.

## Usage

Ask Claude to manage bank accounts, create off-ramp quotes, or execute payments. The plugin provides 7 MCP tools:

| Tool | Description |
|------|-------------|
| `list_bank_accounts` | List saved bank account destinations |
| `create_bank_account` | Add a new bank account (US, CA, UK, IBAN) |
| `delete_bank_account` | Delete a bank account by ID |
| `create_off_ramp_quote` | Create a crypto-to-fiat quote |
| `get_off_ramp_quote` | Check quote status |
| `get_off_ramp_transaction` | Get on-chain transaction params for a quote |
| `list_off_ramps` | List off-ramp transactions |

The `/spritz:spritz` skill gives Claude the full workflow guide, supported networks/tokens, bank account types, and security rules.

## Updating

```bash
/plugin marketplace update spritz-claude
/plugin update spritz@spritz-claude
```

## Prerequisites

- **Spritz API key** — [app.spritz.finance/api-keys](https://app.spritz.finance/api-keys)
- **Crypto wallet** — coming soon
- **Node.js >= 18** — for the MCP server (`npx @spritz-finance/mcp-server`)

## License

MIT
