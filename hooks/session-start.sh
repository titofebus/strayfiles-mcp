#!/bin/sh
# SPDX-License-Identifier: MIT
# SessionStart hook for strayfiles-mcp
# Checks if the strayfiles binary is installed and reachable.
# Never blocks the session — only provides guidance via systemMessage.

# Guard: if HOME is unset or empty, we can't check install locations
if [ -z "${HOME}" ]; then
  echo '{"continue": true}'
  exit 0
fi

# Check if strayfiles is in PATH
if command -v strayfiles >/dev/null 2>&1; then
  echo '{"continue": true}'
  exit 0
fi

# Check the npm auto-download cache location
if [ -x "${HOME}/.strayfiles/bin/strayfiles" ]; then
  cat <<'EOF'
{
  "continue": true,
  "systemMessage": "The strayfiles binary was found at ~/.strayfiles/bin/strayfiles but is not in PATH. The MCP server may fail to start. Suggest the user add it to their PATH:\n\nexport PATH=\"$HOME/.strayfiles/bin:$PATH\"\n\nAdd this line to ~/.bashrc, ~/.zshrc, or the appropriate shell profile."
}
EOF
  exit 0
fi

# Check the default install location
if [ -x "${HOME}/.local/bin/strayfiles" ]; then
  cat <<'EOF'
{
  "continue": true,
  "systemMessage": "The strayfiles binary was found at ~/.local/bin/strayfiles but is not in PATH. The MCP server may fail to start. Suggest the user add it to their PATH:\n\nexport PATH=\"$HOME/.local/bin:$PATH\"\n\nAdd this line to ~/.bashrc, ~/.zshrc, or the appropriate shell profile."
}
EOF
  exit 0
fi

# Binary not found anywhere
cat <<'EOF'
{
  "continue": true,
  "systemMessage": "The strayfiles binary is not installed. Strayfiles MCP tools will not be available until it is installed. If the user wants to manage notes with Strayfiles, suggest they install it:\n\ncurl -fsSL https://strayfiles.com/install.sh | sh\n\nThen restart Claude Code for the MCP server to connect."
}
EOF
exit 0
