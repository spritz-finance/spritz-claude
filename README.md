# Spritz — Claude Code Plugin

Spritz fiat-rail tools for Claude Code, backed by the Spritz MCP server.

## Install

```bash
/plugin marketplace add spritz-finance/spritz-claude
/plugin install spritz@spritz-claude
```

Install the `spritz` CLI as described at
[spritz.finance/install](https://spritz.finance/install).

## Human-approved setup

An AI agent must not accept Developer Terms, complete business verification, or
own a Production credential. A human administrator enrolls the legal entity in
[Developer Access](https://console.spritz.finance) for **Sandbox** or requests
**Live Test**, then approves a scoped device grant. **Production** is a separate
commercial service with its own verification, agreements, and credentials.

On the machine that will run Claude Code:

```bash
spritz auth device start --access developer
# The human opens the returned URL and approves the requested scopes.
spritz auth device complete
spritz auth mcp
```

The plugin starts its MCP server through `spritz auth mcp`, which reads the key
from the system keychain and injects it only into the MCP child process. Do not
put keys in argv, plugin JSON, `.env`, or `~/.config/spritz/api_key`. The broker
starts only the reviewed Spritz MCP server; it cannot run an arbitrary command
that prints the key.

The current device endpoint is an existing Spritz **user-account** flow, not a
Developer Access workspace flow. Developer mode therefore fails closed until
Laurence’s platform endpoints are deployed, and the plugin cannot start its MCP
server locally. Never work around that response by giving an agent a user or raw
Production key.

## Usage

Ask Claude to list approved destinations, create quotes, or inspect off-ramp
status. Use `/spritz:spritz` to load the complete workflow and safety rules.

The plugin exposes:

| Tool | Description |
|------|-------------|
| `list_bank_accounts` | List approved destinations |
| `create_bank_account` | Add a destination after explicit human confirmation |
| `delete_bank_account` | Delete a destination after explicit human confirmation |
| `create_off_ramp_quote` | Create an off-ramp quote |
| `get_off_ramp_quote` | Check quote status |
| `get_off_ramp_transaction` | Get transaction parameters |
| `list_off_ramps` | List off-ramp transactions |

Creating or deleting a destination, creating a fundable quote, and signing or
submitting a transaction each require fresh human confirmation. Sandbox uses
simulated funds; Live Test and Production carry real-money risk.

## Updating

```bash
/plugin marketplace update spritz-claude
/plugin update spritz@spritz-claude
```

## Requirements

- Node.js 18 or newer
- Claude Code
- `spritz` CLI with a human-approved Developer Access workspace credential

## License

MIT
