# Dispatch Claude Sessions via cmux

Launch one or more Claude Code sessions in new cmux tabs using `cmux-dispatch-claude`.

## Instructions

The user's input contains one or more prompts to dispatch. Analyze the input:

**Single prompt**: The input is one task/prompt. Dispatch it as-is.

**Multiple prompts**: The input contains a numbered list, bullet list, or multiple distinct tasks separated by line breaks. Split them into individual prompts and dispatch each one separately.

For each prompt:

1. Save the prompt text to a temp file at `/tmp/cmux/prompts/prompt-N.txt` (create the directory first with `mkdir -p`)
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
- Do NOT add any preamble or context to the prompts - dispatch them exactly as written
- If the user provides short descriptions instead of full prompts, ask them to provide the full prompts before dispatching
