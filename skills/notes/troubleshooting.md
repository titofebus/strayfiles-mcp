# Troubleshooting

Common issues and solutions when using Strayfiles MCP tools.

## "Initialization failed" or tools not responding

**Cause**: The Strayfiles TUI, the macOS desktop app, or another MCP instance has an exclusive lock on `~/.strayfiles/data.redb`.

**Fix**: Close the TUI (`Esc` or `q`) or quit the macOS app before using MCP tools. Only one process can hold the database lock at a time.

## `list_notes` returns empty

**Cause**: No files have been tracked yet. Strayfiles doesn't auto-discover files.

**Fix**: Use the discovery workflow:
1. `discover_files(path="/path/to/your/files")` to scan
2. `track_file(path="...", method="frontmatter")` for each file

## `edit_note` returns a "conflict" status

**Cause**: The note was modified between your `read_note` and `edit_note` calls (by the TUI, another device, or a file watcher).

**Fix**: Read the note again to get the latest version and content, then retry with the new `expected_version`.

## `discover_files` returns "Path is not a directory"

**Cause**: The path doesn't exist or is a file, not a directory.

**Fix**: Ensure the path is absolute and points to an existing directory. Check with the user if unsure.

## `track_file` returns "File does not exist"

**Cause**: The file path is wrong or the file was deleted/moved.

**Fix**: Use `discover_files` first to find the correct path, then `track_file` with the path from results.

## `search_notes` doesn't find a note that exists

**Cause**: `search_notes` only matches note names and aliases — not file content.

**Fix**: To search content, use `list_notes` to get all notes, then `read_note` on candidates. Or narrow results with `tag` and `workspace` filters.

## Mirror sync shows errors

**Cause**: Source file may have been deleted, target directory may not exist, or file permissions prevent writing.

**Fix**: Check `list_mirrors` for the `last_error` field. Verify both source and target paths are accessible. Delete and recreate the mirror if paths have changed.

## "strayfiles binary not found" on session start

**Cause**: The `strayfiles` binary is not installed or not in PATH.

**Fix**: Install with `curl -fsSL https://strayfiles.com/install.sh | sh`, then restart the session.
