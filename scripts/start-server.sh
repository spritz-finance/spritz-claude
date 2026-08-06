#!/usr/bin/env bash
# Start the MCP server through the Spritz CLI credential broker. The broker
# injects the key into this child process without placing it on argv or reading a
# plaintext key file.
exec spritz auth mcp --access user
