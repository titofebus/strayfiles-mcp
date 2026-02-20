# Strayfiles MCP

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Claude Code plugin that connects AI agents to [Strayfiles](https://strayfiles.com) — a local-first markdown notes manager for developers.

## What it does

Gives Claude Code 43 tools for managing your markdown files:

| Category | Tools | Examples |
|----------|-------|---------|
| **Notes** | 10 | List, read, create, edit, delete, rename, move, alias, pin |
| **Search & Discovery** | 3 | Search by name/tag/workspace, discover untracked files, track files |
| **Directories** | 5 | List, create, rename, delete, move |
| **Tags** | 6 | CRUD + tag/untag notes |
| **Workspaces** | 6 | CRUD + assign/unassign notes |
| **Mirrors** | 5 | Setup, sync, update, delete file mirrors |
| **Versions** | 4 | History, read version, diff, restore |
| **Conflicts** | 3 | List, inspect, resolve sync conflicts |
| **Devices** | 1 | List registered devices |

## Install

### Claude Code

```bash
claude plugin install https://github.com/titofebus/strayfiles-mcp.git
```

Or add the MCP server directly:

```bash
claude mcp add --transport stdio strayfiles -- npx -y strayfiles-mcp
```

### Other MCP Clients

Add to your client's MCP config:

```json
{
  "mcpServers": {
    "strayfiles": {
      "command": "npx",
      "args": ["-y", "strayfiles-mcp"]
    }
  }
}
```

Works with Cursor, Windsurf, VS Code, Zed, Codex, and any MCP-compatible client.

### Prerequisites

The Strayfiles binary must be installed. The plugin will tell you if it's missing, or install it now:

```bash
curl -fsSL https://strayfiles.com/install.sh | sh
```

This installs only the `strayfiles` CLI/TUI binary required by MCP (not the
full macOS app bundle or DMG).

Supported platforms: macOS (Apple Silicon, Intel), Linux (x64, arm64).

## Authentication (Optional)

`strayfiles mcp` works without login for local file management. This keeps the
plugin fully usable as an open-source, local-first MCP server.

If you want to link your Strayfiles account session:

```bash
strayfiles mcp auth    # Sign in (browser token flow + online verification)
strayfiles mcp status  # Show MCP client setup + auth status
strayfiles mcp logout  # Clear stored credentials
```

Important:
- `strayfiles mcp auth` links account credentials only.
- Cross-device note sync requires Strayfiles Pro and a running sync engine
  (`strayfiles --serve` or app sync).
- Free tier users can still use all local MCP note-management tools; cloud sync
  is unavailable on free.

## Usage

Once installed, Claude Code automatically has access to all Strayfiles tools. Just ask naturally:

- "Find all CLAUDE.md files in my projects directory"
- "Track this README with html_comment metadata"
- "Show me my notes tagged with 'rust'"
- "What changed in version 3 of my notes file?"
- "Set up a mirror of CLAUDE.md to my other repo"
- "Create a workspace called 'work' and add these notes to it"

## Important notes

- **Database lock**: Strayfiles uses an exclusive database lock. If the TUI is open, close it before using MCP tools.
- **File-first**: Notes are real .md files on disk. The database stores only metadata.
- **Edit is replace**: `edit_note` replaces the entire file content. Claude will read first, then write back the full content.

## Links

- [Strayfiles](https://strayfiles.com)
- [Documentation](https://strayfiles.com/docs)
- [CLI Reference](https://strayfiles.com/docs/reference/cli)
- [Contributing](CONTRIBUTING.md)
- [Changelog](CHANGELOG.md)
