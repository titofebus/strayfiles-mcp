# Workflow Examples

Common multi-step workflows using Strayfiles MCP tools.

## Track all CLAUDE.md files in a projects directory

```
1. discover_files(path="/Users/me/projects", pattern="CLAUDE")
2. Review the list of discovered files
3. track_file(path="/Users/me/projects/app/CLAUDE.md", method="html_comment")
   # html_comment because CLAUDE.md is read by AI tools — no visible changes
4. Repeat for each file to track
```

## Organize notes into a workspace

```
1. list_workspaces()                              # Check existing workspaces
2. create_workspace(name="work", color="#3b82f6")  # Create if missing
3. search_notes(query="project")                   # Find relevant notes
4. assign_workspace(note_id="...", workspace_id="...")  # Add each note
```

## Set up a mirror for CLAUDE.md across repos

```
1. setup_mirror(
     source_path="/Users/me/projects/main-repo/CLAUDE.md",
     target_path="/Users/me/projects/other-repo/CLAUDE.md"
   )
2. sync_mirrors()  # Perform initial copy
3. list_mirrors()  # Verify status
```

## Edit a note safely with version checking

```
1. read_note(note_id="...")                        # Get current content + version
2. edit_note(
     note_id="...",
     content="...updated content...",
     expected_version=5                             # Prevent overwriting concurrent edits
   )
3. If status is "conflict" — another edit happened concurrently:
   a. read_note again to get latest content
   b. Merge changes manually
   c. edit_note with the new expected_version
```

## Restore a previous version of a note

```
1. version_history(note_id="...")                  # List all versions
2. diff_versions(note_id="...", from_version=3, to_version=5)  # Compare
3. read_version(note_id="...", version_number=3)   # Preview the old version
4. restore_version(note_id="...", version_number=3) # Revert (creates new snapshot)
```

## Resolve a sync conflict

```
1. list_conflicts()                                # Find unresolved conflicts
2. get_conflict(conflict_id="...")                  # Inspect base, local, remote content
3. Option A: resolve_conflict(conflict_id="...", resolution="keep_local")
   Option B: resolve_conflict(conflict_id="...", resolution="auto_merge")
   Option C: Manually merge:
     a. Compose merged content from local + remote
     b. edit_note(note_id="...", content="...merged...")
     c. resolve_conflict(conflict_id="...", resolution="keep_local")
```
