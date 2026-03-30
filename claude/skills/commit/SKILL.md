---
name: commit
description: Commit all current changes with an appropriate commit message
disable-model-invocation: true
---

Commit ONLY the files that were modified during this session. Do not stage or commit any files that you did not touch.

Before committing, check the full diff of each file you modified. If a file contains changes that you did not make (e.g., from another agent or manual edits), warn the user and list which files have external changes. Let the user decide whether to include or exclude those files before proceeding.

Review the diff, write a clear commit message, and create the commit. Do not push.
