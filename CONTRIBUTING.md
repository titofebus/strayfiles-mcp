# Contributing to Strayfiles MCP

Thanks for your interest in contributing to the Strayfiles MCP plugin.

## What lives here

This repo contains the **Claude Code plugin wrapper** — config files, skills, hooks, and documentation. The actual MCP server is a compiled binary built from source at [strayfiles.com](https://strayfiles.com).

## How to contribute

### Skills and documentation

The most impactful contributions are improvements to the skill definitions and documentation:

- **`skills/notes/SKILL.md`** — Workflow guidance for Claude on how to use the 43 tools
- **`README.md`** — User-facing documentation
- Better examples, clearer explanations, additional workflow patterns

### Hooks

The `hooks/session-start.sh` script checks binary availability. Improvements to error messaging or platform detection are welcome.

### Bug reports

If MCP tools aren't working correctly, file an issue with:
1. Your platform (macOS/Linux, architecture)
2. `strayfiles --version` output
3. The tool call that failed and the error message

### MCP server bugs

For bugs in the MCP server itself (tool behavior, protocol issues), please file issues on this repo — we'll triage and route them appropriately.

## Development

Test the plugin locally without installing:

```bash
claude --plugin-dir ./
```

## Code of conduct

Be respectful. We're all here to build useful tools.
