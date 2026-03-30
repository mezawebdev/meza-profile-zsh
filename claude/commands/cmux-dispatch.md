# Dispatch Claude Sessions via cmux

Launch one or more Claude Code sessions in new cmux tabs using `cmux-dispatch-claude`.

## Instructions

The user's input contains one or more prompts to dispatch. Analyze the input:

**Single prompt**: The input is one task/prompt.

**Multiple prompts**: The input contains a numbered list, bullet list, or multiple distinct tasks separated by line breaks. Split them into individual prompts.

### Research Phase

Before dispatching, do a **quick research pass** on each prompt to understand the ask. This does NOT need to be exhaustive — just enough to give the worker agent useful context. For each prompt:

1. **Understand the intent**: Is it a bug fix, new feature, refactor, config change, etc.?
2. **Find relevant files**: Use Glob/Grep to identify the key files the worker will need to touch or reference. List specific file paths.
3. **Gather context**: Read the most relevant files (just enough to understand the current state — don't read everything). Note any patterns, conventions, or dependencies the worker should be aware of.
4. **Identify related features**: Are there related components, tests, or configs that might be affected?

### Enriched Prompt Format

Rewrite each prompt into an enriched version using this structure:

```
## Task
<Clear description of what needs to be done — restate the user's ask in precise, actionable terms>

## Context
<Brief summary of what you found during research — current state, how things work now, why the change is needed>

## Relevant Files
<List of specific file paths the worker should read/modify, with a one-line note on each>

## Notes
<Any gotchas, conventions, dependencies, or suggestions you noticed during research>

## Original Prompt
<The user's original prompt, preserved verbatim for reference>
```

### Dispatch Phase

For each enriched prompt:

1. Save the enriched prompt to a temp file at `/tmp/cmux/prompts/prompt-N.txt` (create the directory first with `mkdir -p`)
2. Generate a short tab name (2-4 words, kebab-case) that describes the task
3. Run: `cmux-dispatch-claude -n "<tab-name>" -f /tmp/cmux/prompts/prompt-N.txt`
4. After all sessions are dispatched, clean up: `rm -rf /tmp/cmux/prompts`
5. Report which sessions were launched

## Important

- Always use `-f` with a temp file rather than passing the prompt as an argument (avoids escaping issues)
- The working directory defaults to the current directory, which is correct for this project
- Stagger launches with a brief pause between them (`sleep 0.5`)
- After dispatching, list all the tab names and their surface IDs so the user can track them
- Always clean up `/tmp/cmux/prompts/` after all dispatches are complete
- The research phase should be quick — spend ~30 seconds per prompt, not minutes. Skim, don't deep-dive.
- Keep the enriched prompt concise. The worker agent will do its own reading — you're just giving it a head start.
- If the user provides extremely vague descriptions (e.g., just a single word), ask for clarification before researching and dispatching
