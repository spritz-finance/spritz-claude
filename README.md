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

The plugin's MCP entry currently invokes `spritz auth mcp --access user`, which
is intentionally fail-closed. The CLI does not pass a keychain credential to a
package launched through an ambient Node/npm runtime because that is not a
credential-security boundary against same-user local code. Completing device
authorization does not enable this plugin's MCP tools in the current release.

Do not work around the block by putting a key in argv, plugin JSON, `.env`, or
`~/.config/spritz/api_key`. Wait for Spritz to ship an integrity-verifiable
packaged broker. The standalone MCP server documents a disposable Sandbox/test
operator path, but it must not be used with a Production End User account.

Developer workspace access is a different principal and credential model. A
Developer may be an individual or organization. The individual, or a person
authorized for the organization, creates one workspace and obtains Developer
HMAC credentials through the
[Developer Access flow](https://docs.spritz.finance/guides/developer-access).
Do not substitute one type of credential for the other.

## Usage

After a compatible packaged broker ships, ask Claude to list approved
destinations or inspect existing off-ramp and quote status. Use
`/spritz:spritz` to load the complete workflow and safety rules.

The plugin exposes:

| Tool | Description |
|------|-------------|
| `list_bank_accounts` | List approved destinations |
| `get_off_ramp_quote` | Check quote status |
| `list_off_ramps` | List off-ramp transactions |

These tools are GET-only and act on the approving human's End User account.
Mutating destinations, creating a fundable quote, retrieving a transaction for
signing, signing, and submission are deliberately absent until Spritz can
verify a short-lived approval grant bound to the exact action. Tool metadata or
a chat confirmation is not an authorization control.

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
- `spritz` CLI; the MCP integration remains unavailable until a compatible
  integrity-verifiable packaged broker ships

## License

MIT
