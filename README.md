# Spritz — Claude Code Plugin

Off-ramp crypto to fiat bank accounts using Spritz Finance MCP tools in [Claude Code](https://claude.ai/code).

## Quick Start

### 1. Get your API key

Sign up at [app.spritz.finance/api-key](https://app.spritz.finance/api-key).

### 2. Install the plugin

```bash
/plugin marketplace add spritz-finance/spritz-claude
/plugin install spritz@spritz-claude
```

### 3. Add your API key

```bash
mkdir -p ~/.config/spritz
echo "your-api-key" > ~/.config/spritz/api_key
```

### 4. Restart Claude Code

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
| `get_off_ramp_transaction` | Get on-chain transaction params |
| `list_off_ramps` | List off-ramp transactions |

Use `/spritz:spritz` to load the full workflow guide with supported networks, bank account types, and security rules.

## Supported Networks

Ethereum, Polygon, Arbitrum, Base, Optimism, Avalanche, BSC, Solana, Bitcoin, and more.

## Updating

```bash
/plugin marketplace update spritz-claude
/plugin update spritz@spritz-claude
```

## Prerequisites

- **Spritz API key** — [app.spritz.finance/api-key](https://app.spritz.finance/api-key)
- **Node.js >= 18** — for the MCP server
- **Claude Code** — [claude.ai/code](https://claude.ai/code)

## License

MIT
