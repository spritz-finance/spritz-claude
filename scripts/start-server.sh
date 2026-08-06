#!/usr/bin/env bash
# This entry is intentionally fail-closed until the CLI can launch an
# integrity-verifiable packaged MCP child. It must never fall back to a raw key.
exec spritz auth mcp --access user
