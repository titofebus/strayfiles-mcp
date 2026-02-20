#!/bin/sh
# SPDX-License-Identifier: MIT
# Strayfiles MCP plugin — binary installer
#
# Ensures the strayfiles CLI/TUI binary is available for the MCP server.
# Delegates to the canonical install script at strayfiles.com.
#
# Usage:
#   sh install.sh
#   # or directly:
#   curl -fsSL https://strayfiles.com/install.sh | sh

set -e

echo "Strayfiles MCP Plugin Setup"
echo ""

# Check if strayfiles is already in PATH
if command -v strayfiles >/dev/null 2>&1; then
  VERSION=$(strayfiles --version 2>/dev/null | head -n 1)
  echo "Strayfiles is already installed: ${VERSION}"
  echo ""
  echo "The MCP server is ready. Claude Code will connect automatically."
  exit 0
fi

# Check the default install location
if [ -x "${HOME}/.local/bin/strayfiles" ]; then
  echo "Strayfiles found at ~/.local/bin/strayfiles (not in PATH)."
  echo ""
  echo "Add to your shell profile:"
  echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
  echo ""
  echo "Then restart Claude Code for the MCP server to connect."
  exit 0
fi

# Verify curl is available (canonical install script requires it)
if ! command -v curl >/dev/null 2>&1; then
  echo "Error: curl is required to install Strayfiles." >&2
  echo "" >&2
  echo "Install curl first, then re-run this script." >&2
  echo "  macOS:  curl is pre-installed" >&2
  echo "  Ubuntu: sudo apt install curl" >&2
  echo "  Fedora: sudo dnf install curl" >&2
  exit 1
fi

echo "Strayfiles binary not found. Installing..."
echo ""

# Delegate to the canonical install script
curl -fsSL https://strayfiles.com/install.sh | sh

echo ""
echo "MCP server ready. Restart Claude Code for the tools to connect."
