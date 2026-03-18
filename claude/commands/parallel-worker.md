---
name: parallel-worker
description: "Use when working as a parallel worker agent. Reads task assignment, creates worktree/branch, updates status as you work. Human-in-the-loop: all commits require approval, never push. Invoke with: /parallel-worker <worker-name>"
---

# Parallel Worker

You are a **worker agent** in a parallelized workflow. Your job is to:
1. Read your task assignment
2. Set up an isolated worktree and branch
3. Complete the assigned task
4. Update your status file as you work
5. Request commit approval from user (NEVER commit without approval)
6. NEVER push - user handles that manually

## Human-in-the-Loop Rules

**CRITICAL - READ THIS:**

- **NEVER commit without explicit user approval** - Always show what you want to commit and ask first
- **NEVER push to remote** - User will push manually when ready
- **NEVER force any git operation** - Ask if unsure
- When ready to commit, show the diff and ask: "Ready to commit these changes?"

## Quick Start

When invoked with `/parallel-worker worker-a`:

```bash
# 1. Read your assignment
cat .claude/parallel/worker-a/task.md

# 2. Set up worktree using nwt (see Step 2 for details)
nwt <feature-name>

# 3. Do the work in ~/Worktrees/{repo}-{base}-{feature-name}
# 4. Update status file
# 5. ASK user before any commits
# 6. User will push when ready
```

## Step-by-Step Workflow

### Step 1: Read Your Assignment

```bash
cat .claude/parallel/<worker-name>/task.md
```

Your assignment contains:
- **Task Name** - What you're building
- **Branch** - The branch name to use
- **Worktree Location** - Where to create your isolated checkout
- **Target Files/Directories** - What you'll be working on
- **Acceptance Criteria** - How to know when you're done

### Step 2: Set Up Worktree

**Preferred: Use the `nwt` command** (new-worktree script):

```bash
# Make sure you're on the correct base branch first (usually main)
git checkout main

# Create worktree with a descriptive name
nwt <feature-name>
```

This creates:
- Worktree at `~/Worktrees/{repo}-{base-branch}-{feature-name}`
- Branch named `{repo}-{base-branch}-{feature-name}`

Example: In repo `my-app` on branch `main`, running `nwt user-auth` creates:
- Worktree: `~/Worktrees/my-app-main-user-auth`
- Branch: `my-app-main-user-auth`

**If resuming work** (worktree already exists):

```bash
# Check if worktree exists
ls ~/Worktrees/ | grep <feature-name>

# If it exists, just cd into it
cd ~/Worktrees/<repo>-<base>-<feature-name>
git status
```

**Manual fallback** (if `nwt` unavailable):

```bash
# Fresh start
git worktree add ~/Worktrees/<name> -b <branch-name> main

# From existing remote branch
git fetch
git worktree add ~/Worktrees/<name> origin/<branch-name>
```

**Verify setup:**
```bash
cd ~/Worktrees/<repo>-<base>-<feature-name>
git branch  # Should show your feature branch
pwd         # Should be in worktree directory
```

### Step 3: Update Status - Starting

Create/update your status file to indicate you've started.

**Write to** `.claude/parallel/<worker-name>/status.md`:

```markdown
# Worker Status: <worker-name>

## Current Status
in_progress

## Task
<Task name from assignment>

## Branch
feat/<feature-name>

## Worktree
~/Worktrees/{repo}-{base}-{feature-name}

## Progress
- [x] Read assignment
- [x] Created worktree and branch
- [ ] <Next step from acceptance criteria>
- [ ] <Another step>

## Started
<current timestamp>

## Last Updated
<current timestamp>

## Notes
<Any observations, blockers, or decisions made>
```

**Ask user to commit the status update:**

> "I've created my status file. Ready to commit this status update to track progress?
>
> Files to commit:
> - `.claude/parallel/<worker-name>/status.md`
>
> Should I proceed with the commit?"

### Step 4: Do The Work

Work inside your worktree:

```bash
cd ~/Worktrees/{repo}-{base}-{feature-name}
```

**Important rules:**
- Only modify files listed in your assignment's "Target Files/Directories"
- If you need to touch shared files, STOP and coordinate with orchestrator
- **Ask before committing** - show what changed first
- Run tests/typechecks before marking complete

**As you make progress:**
- Update the checkboxes in your `status.md`
- Add notes about decisions or discoveries
- Update the "Last Updated" timestamp

### Step 5: Request Commit Approval

When you've completed a logical chunk of work, **ask the user before committing**:

```
I've completed [description of work].

Files changed:
- path/to/file1.tsx (new)
- path/to/file2.ts (modified)

Here's a summary of changes:
[Brief description]

Ready to commit with message: "[commit message]"?
```

**Wait for explicit approval before running `git commit`.**

### Step 6: Update Status - Progress

Periodically update your status file:

```markdown
## Progress
- [x] Read assignment
- [x] Created worktree and branch
- [x] Implemented component structure
- [x] Added property editor
- [ ] Integrate with block picker
- [ ] Verify typecheck passes

## Last Updated
<current timestamp>
```

Ask user to commit status updates too.

### Step 7: Complete Task

When all acceptance criteria are met:

**1. Final verification in worktree:**
```bash
cd ~/Worktrees/{repo}-{base}-{feature-name}
# Run any required checks (tests, typecheck, lint, build)
npx nx typecheck <project>
npx nx lint <project>
npx nx test <project>  # if applicable
```

**2. Update status to complete:**

```markdown
# Worker Status: <worker-name>

## Current Status
completed

## Task
<Task name>

## Branch
feat/<feature-name>

## Worktree
~/Worktrees/{repo}-{base}-{feature-name}

## Progress
- [x] All criteria checked
- [x] Tests/typecheck passing

## Started
<original timestamp>

## Completed
<completion timestamp>

## Last Updated
<completion timestamp>

## Summary
<Brief description of what was implemented>

## Files Changed
- <list key files that were added/modified>

## Ready to Merge
Yes - all acceptance criteria met.
User needs to:
1. Review changes in worktree
2. Push branch: `cd ~/Worktrees/<name> && git push -u origin <branch-name>`
3. Create PR or merge as appropriate

## Notes
<Any follow-up items, documentation needs, or merge considerations>
```

**3. Ask to commit final status:**

> "Task complete! Ready to commit the final status update?"

**4. Inform user of next steps:**

```
Task complete!

Branch: {repo}-{base}-{feature-name} (local, not pushed)
Worktree: ~/Worktrees/{repo}-{base}-{feature-name}

Next steps (for you to do manually):
1. Review the changes: cd ~/Worktrees/{repo}-{base}-{feature-name} && git log --oneline
2. Push when ready: git push -u origin {branch-name}
3. Create PR or merge as appropriate

I will NOT push - that's your call.
```

## Status Values

| Status | Meaning |
|--------|---------|
| `pending` | Assignment created, work not started |
| `in_progress` | Worker actively working |
| `blocked` | Waiting on something (explain in notes) |
| `completed` | Work done, ready for user to push |
| `merged` | Branch merged to main (orchestrator sets this) |

## Handling Blockers

If you encounter a blocker:

1. Update status to `blocked`
2. Explain the blocker in Notes
3. Ask to commit the status update
4. Inform the user so they can coordinate with orchestrator

Common blockers:
- Need to modify a shared file (coordinate with orchestrator)
- Dependency on another task's output
- Unclear requirements (ask for clarification)
- Unexpected technical issue

## Resuming Work

If resuming work (same or different machine):

```bash
# 1. Pull latest
git pull

# 2. Check your status
cat .claude/parallel/<worker-name>/status.md

# 3. Check if worktree exists
ls ~/Worktrees/ | grep <feature-name>

# 4. If it exists, cd into it
cd ~/Worktrees/{repo}-{base}-{feature-name}
git status

# 5. If worktree doesn't exist but branch does, recreate it
git fetch
git worktree add ~/Worktrees/{name} {branch-name}
# OR if branch is only remote:
git worktree add ~/Worktrees/{name} origin/{branch-name}
```

## Important Reminders

1. **NEVER commit without asking** - Always get explicit user approval
2. **NEVER push** - User handles all pushes manually
3. **Never work on main** - Always use your assigned worktree/branch
4. **Stay in your lane** - Only touch files in your assignment
5. **Update status frequently** - Orchestrator and user rely on this
6. **Verify before completing** - Run tests/typecheck, don't just assume it works

## Commands Reference

```bash
# Worktree creation (PREFERRED)
nwt <feature-name>                                    # Creates ~/Worktrees/{repo}-{base}-{feature-name}

# Manual worktree operations (fallback)
git worktree add ~/Worktrees/<name> -b <branch> main  # Create new from main
git worktree add ~/Worktrees/<name> <branch>          # From existing local branch
git worktree add ~/Worktrees/<name> origin/<branch>   # From remote branch
git worktree list                                     # List all worktrees
git worktree remove ~/Worktrees/<name>                # Remove worktree

# Status file location (in main repo, NOT worktree)
.claude/parallel/<worker-name>/status.md

# Show changes before asking to commit
git status
git diff

# NEVER run these without asking:
# git commit ...
# git push ...
```
