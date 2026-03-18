---
name: parallel-orchestrator
description: "Use when you need to parallelize work across multiple Claude instances. Analyzes task lists, identifies independent work streams, creates task assignments, and monitors worker progress. Invoke with: /parallel-orchestrator"
---

# Parallel Orchestrator

Coordinate parallel work across multiple Claude CLI instances by analyzing tasks, creating assignments, and tracking worker progress.

## Overview

You are the **orchestrator** - your job is to:
1. Analyze a task list or strategy document
2. Identify tasks that can be parallelized (no file conflicts)
3. Create task assignments for worker agents
4. Monitor worker progress via status files
5. Coordinate merges when workers complete

## Directory Structure

**IMPORTANT:** Task files live in the **project repository**, not in the global Claude config. This skill is reusable across projects, but each project has its own `.claude/parallel/` directory.

All coordination files are committed to git (except `.worktrees/`):

```
<project-root>/
  .claude/parallel/            # Tracked in git (project-specific)
    active.md                  # Master file: all tasks overview
    worker-a/
      task.md                  # Assignment (you write)
      status.md                # Progress (worker writes)
    worker-b/
      task.md
      status.md

  .worktrees/                  # Gitignored (local only)
    feature-name/              # Worker's isolated checkout
```

The `.gitignore` should include:
```gitignore
.worktrees/
```

But `.claude/parallel/` should **NOT** be gitignored - it needs to be committed so:
- Workers can read their assignments
- Progress persists across sessions
- Work can resume on different machines

## Workflow

### Step 1: Analyze Tasks

When given a task list or strategy document:

1. **Read the source document** - Understand all tasks and their scope
2. **Map tasks to file paths** - Identify which directories/files each task touches
3. **Find independent streams** - Tasks that don't share files can be parallelized
4. **Consider data dependencies** - Even without file conflicts, some tasks depend on others

### Step 2: Create Assignments

For each parallelizable task, create:

**1. Worker directory:**
```bash
mkdir -p .claude/parallel/worker-a
```

**2. Task assignment file** (`.claude/parallel/worker-a/task.md`):

```markdown
# Task Assignment: Worker A

## Task Name
[Clear, descriptive name]

## Branch
feat/[kebab-case-name]

## Worktree Location
.worktrees/[kebab-case-name]

## Source Reference
- Document: [path to strategy/spec doc]
- Section: [specific section reference]

## Target Files/Directories
- [List specific paths this task will touch]
- [Be explicit to avoid conflicts]

## Context
[Brief explanation of what this task accomplishes and why]

## Acceptance Criteria
- [ ] [Specific, testable criterion]
- [ ] [Another criterion]
- [ ] [Tests pass / types check / etc.]

## Notes
[Any gotchas, related tasks, or helpful tips]
```

**3. Master tracking file** (`.claude/parallel/active.md`):

```markdown
# Active Parallel Tasks

Last updated: [timestamp]

## Overview
[Brief description of what's being parallelized]

## Workers

| Worker | Task | Branch | Worktree | Status | Last Update |
|--------|------|--------|----------|--------|-------------|
| worker-a | [Task Name] | feat/xyz | .worktrees/xyz | pending | - |
| worker-b | [Task Name] | feat/abc | .worktrees/abc | pending | - |

## Merge Order
1. [Which branch should merge first, if order matters]
2. [Next branch]

## Notes
[Any coordination notes, potential conflicts to watch]
```

### Step 3: Commit Assignments

```bash
git add .claude/parallel/
git commit -m "parallel: Create task assignments for [description]"
```

### Step 4: Instruct User

Tell the user:

```
Task assignments created. To start workers:

1. Open a new terminal for each worker
2. Run `claude` in each terminal
3. Tell each worker: `/parallel-worker worker-a` (or worker-b, etc.)

Workers will:
- Create their worktree and branch
- Read their assignment
- Update their status file as they work
- Ask YOU before any commits (human-in-the-loop)
- NEVER push - you handle that manually when ready
```

### Step 5: Monitor Progress

To check worker status:

```bash
# Read all status files
cat .claude/parallel/*/status.md

# Check local branches
git branch | grep feat/

# Check worktrees
git worktree list
```

Update `active.md` with current status as workers report progress.

### Step 6: Coordinate Merges

When workers mark tasks as complete:

1. **User pushes branches** (workers don't push):
   ```bash
   cd .worktrees/<feature-name>
   git push -u origin feat/<feature-name>
   ```

2. Review each branch (or create PRs)
3. Merge in the order specified in `active.md`
4. Handle any conflicts
5. Update `active.md` to mark tasks merged
6. Clean up:
   ```bash
   git worktree remove .worktrees/<feature-name>
   rm -rf .claude/parallel/<worker-name>
   ```

## Parallelization Guidelines

### Safe to Parallelize

- **Different directories**: `apps/frontend/` vs `apps/backend/`
- **Different feature modules**: `features/auth/` vs `features/editor/`
- **New files only**: Both tasks create new files, no shared dependencies
- **Frontend vs Backend**: Different apps entirely

### Risky - Needs Coordination

- **Shared utilities**: Both tasks might modify `lib/utils.ts`
- **Shared types**: Both might update `types/index.ts`
- **Config files**: `package.json`, `tsconfig.json`, etc.
- **Sequential dependencies**: Task B needs Task A's output

### Never Parallelize

- **Same files**: Direct conflict guaranteed
- **Tightly coupled features**: Changes interleave in same components
- **Database migrations**: Order matters, conflicts likely

## Example Analysis

Given a V1 strategy with these tasks:
- Social Links Block (new component)
- Artist Header Block (new component)
- Access Management UI (config page)
- Custom Domains Backend (Laravel API)

**Analysis:**

| Task | Target Path | Dependencies | Parallelizable With |
|------|------------|--------------|---------------------|
| Social Links Block | `features/editor/blocks/social-links/` | Block system | Artist Header Block |
| Artist Header Block | `features/editor/blocks/artist-header/` | Block system | Social Links Block |
| Access Management UI | `apps/greenroom/src/app/dashboard/config/` | None | Both blocks, Custom Domains |
| Custom Domains Backend | `apps/greenroom-api/` | None | All frontend tasks |

**Recommendation:**
- Stream A: Social Links Block
- Stream B: Artist Header Block

(These create entirely new directories with no overlap)

## Commands Reference

```bash
# Create worker directory
mkdir -p .claude/parallel/worker-{a,b,c}

# Check worker status
cat .claude/parallel/*/status.md

# View all active branches
git branch -a | grep feat/

# Fetch remote updates
git fetch --all

# View worker's commits
git log origin/feat/branch-name --oneline -10

# Clean up after merge
rm -rf .claude/parallel/worker-a
git worktree remove .worktrees/feature-name
```

## Handling Resumption on New Machine

If you're continuing work on a different machine:

1. **Pull latest** - Get the coordination files
   ```bash
   git pull
   ```

2. **Check active tasks** - See what's in progress
   ```bash
   cat .claude/parallel/active.md
   ```

3. **Recreate worktrees** - For any in-progress tasks
   ```bash
   # If branch exists remotely
   git fetch
   git worktree add .worktrees/feature-name origin/feat/feature-name

   # Or from local branch
   git worktree add .worktrees/feature-name feat/feature-name
   ```

4. **Continue coordination** - Status files show where each worker left off
