# Spritz — Claude Code Plugin

Spritz fiat-rail tools for Claude Code, backed by the Spritz MCP server and an
individual Spritz **End User account**.

## Install

```bash
/plugin marketplace add spritz-finance/spritz-claude
/plugin install spritz@spritz-claude
```

Install the `spritz` CLI as described at
[spritz.finance/install](https://spritz.finance/install).

## Human-approved setup

The owner of the affected Spritz account must approve access. An AI agent must
not create the account, perform identity verification, approve its own device
grant, or obtain a credential outside this flow.

On the machine that will run Claude Code:

```bash
spritz auth device start --access user
# The account owner opens the returned URL and approves the requested scopes.
spritz auth device complete
```

Restart Claude Code after approval. The plugin launches `spritz auth mcp
--access user` as its long-lived stdio server; running that broker manually as
a one-time setup step only leaves it waiting for MCP protocol messages. The
CLI reads the End User Bearer credential from the system keychain and injects
it only into the fixed MCP child process. Do not put keys in argv, plugin JSON,
`.env`, or `~/.config/spritz/api_key`.

Developer workspace access is a different principal and credential model. A
Developer may be an individual or organization. The individual, or a person
authorized for the organization, creates one workspace and obtains Developer
HMAC credentials through the
[Developer Access flow](https://docs.spritz.finance/guides/developer-access).
Do not substitute one type of credential for the other.

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

These tools act on the approving human's End User account. Creating or deleting
a destination, creating a fundable quote, and signing or submitting a
transaction each require fresh human confirmation. A live account carries
real-money risk.

## Updating

```bash
/plugin marketplace update spritz-claude
/plugin update spritz@spritz-claude
```

## Development

```bash
./scripts/validate.sh
```

## Requirements

- Node.js 18 or newer
- Claude Code
- `spritz` CLI with a human-approved End User account credential

## License

MIT
