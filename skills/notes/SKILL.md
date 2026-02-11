---
name: strayfiles
description: Manage markdown notes tracked by Strayfiles — a local-first notes system where .md files stay on disk and Strayfiles adds lightweight metadata. Use when the user asks about their notes, wants to find or track files, edit markdown content, organize with tags or workspaces, set up file mirrors, view version history, or resolve sync conflicts.
allowed-tools: mcp__strayfiles__list_notes, mcp__strayfiles__read_note, mcp__strayfiles__get_note, mcp__strayfiles__create_note, mcp__strayfiles__edit_note, mcp__strayfiles__delete_note, mcp__strayfiles__rename_note, mcp__strayfiles__move_note, mcp__strayfiles__set_note_alias, mcp__strayfiles__toggle_note_pin, mcp__strayfiles__search_notes, mcp__strayfiles__discover_files, mcp__strayfiles__track_file, mcp__strayfiles__list_directories, mcp__strayfiles__create_directory, mcp__strayfiles__rename_directory, mcp__strayfiles__delete_directory, mcp__strayfiles__move_directory, mcp__strayfiles__list_tags, mcp__strayfiles__create_tag, mcp__strayfiles__update_tag, mcp__strayfiles__delete_tag, mcp__strayfiles__tag_note, mcp__strayfiles__untag_note, mcp__strayfiles__list_workspaces, mcp__strayfiles__create_workspace, mcp__strayfiles__update_workspace, mcp__strayfiles__delete_workspace, mcp__strayfiles__assign_workspace, mcp__strayfiles__unassign_workspace, mcp__strayfiles__list_mirrors, mcp__strayfiles__setup_mirror, mcp__strayfiles__update_mirror, mcp__strayfiles__delete_mirror, mcp__strayfiles__sync_mirrors, mcp__strayfiles__version_history, mcp__strayfiles__read_version, mcp__strayfiles__diff_versions, mcp__strayfiles__restore_version, mcp__strayfiles__list_conflicts, mcp__strayfiles__get_conflict, mcp__strayfiles__resolve_conflict, mcp__strayfiles__list_devices
---

# Strayfiles

Local-first markdown notes manager for developers. Notes are real .md files on disk — Strayfiles tracks them with UUID metadata and provides organization, version history, and sync.

## Important: Database Lock

Strayfiles uses an exclusive lock on `~/.strayfiles/data.redb`. If the Strayfiles TUI is open, the MCP server cannot start. If tools return initialization errors, ask the user to close the TUI first.

## Getting Started (Empty Database)

If `list_notes` returns empty, the user hasn't tracked any files yet. Guide them through discovery:

1. Ask where their markdown files live, or check the current project directory
2. `discover_files` with that path to scan for .md files — shows which are already tracked
3. Show the user what was found and let them choose which to track
4. `track_file` on each file they want:
   - **frontmatter** (default): Adds YAML header with UUID — best for personal notes
   - **html_comment**: Adds invisible `<!-- strayfiles: ... -->` — best for READMEs and public docs
5. Or use `create_note` to create brand new notes

## Notes

### Reading & Editing

- Always `read_note` before `edit_note` — editing replaces the ENTIRE file content, not a patch
- Use `expected_version` in `edit_note` for optimistic concurrency to avoid overwriting concurrent changes
- `get_note` returns metadata including tags and workspaces (but not content)
- `read_note` returns content (but not tags/workspaces)

### Search

- `search_notes` matches note names and aliases only — it does NOT search file content
- To find content: `list_notes` then `read_note` on candidates
- Combine `tag` + `workspace` filters (AND semantics)

### Organization

- `set_note_alias` gives a display name different from the filename (e.g., alias "Project README" for "README")
- `toggle_note_pin` pins notes to the top of lists
- `move_note` moves within Strayfiles directory hierarchy, not the filesystem
- `delete_note` is irreversible — deletes the .md file for file-backed notes

## Discovery & Tracking

- `discover_files` scans a directory for .md files and reports tracking status — requires an absolute path
- Common patterns: `discover_files(path="/Users/user/projects")`, `discover_files(path="/path", pattern="CLAUDE")`
- `track_file` injects UUID metadata and registers the file — if already tracked, re-registers with existing ID

## Directories

Strayfiles has its own internal folder hierarchy separate from the filesystem:

- `list_directories` to navigate (use `parent_id` to drill down)
- `create_directory` / `rename_directory` / `move_directory` for management
- `delete_directory` is destructive — removes all notes and subdirectories inside

## Tags

Labels for categorizing notes (like Gmail labels):

- `list_tags` before `create_tag` — check for existing tags first
- A note can have many tags; `tag_note` / `untag_note` to manage
- Tags have optional color, icon, and description

## Workspaces

Virtual folders that group notes without moving files on disk:

- Different from tags: workspaces are for grouping, tags are for labeling
- A note can belong to multiple workspaces
- `list_workspaces` before `create_workspace` — check for existing ones
- `assign_workspace` / `unassign_workspace` to manage membership
- `delete_workspace` removes assignments but does NOT delete notes

## Mirrors

One-way file sync — when a source file changes, it is automatically copied to target locations:

- `setup_mirror` with absolute source and target paths
- `sync_mirrors` to perform the initial copy (or force sync)
- `list_mirrors` to check sync status and errors
- `delete_mirror` with `delete_target: true` also removes the mirrored file
- Use case: keep CLAUDE.md synced across multiple repos

## Version History

Every edit creates an automatic snapshot:

1. `version_history` — list saved versions with timestamps
2. `read_version` — preview a specific version (non-destructive)
3. `diff_versions` — compare two versions (unified diff format)
4. `restore_version` — revert to a previous version (creates new snapshot)

Always `read_version` or `diff_versions` before `restore_version` to confirm the content.

## Conflicts

Conflicts occur when the same note is edited on multiple devices:

1. `list_conflicts` — find unresolved conflicts (optionally filter by note_id)
2. `get_conflict` — inspect base, local, and remote content
3. `resolve_conflict` with:
   - `keep_local` — use this device's version
   - `keep_remote` — use the other device's version
   - `auto_merge` — attempt 3-way merge

For manual resolution: read both versions, compose merged content with `edit_note`, then `resolve_conflict` with `keep_local`.

## Devices

`list_devices` shows all registered devices. Notes are mapped to file paths per device, so the same note can live at different paths on different machines.
