---
name: what
description: "Quick steer back into the conversation after getting distracted. Re-summarizes what we were just doing in one or two concise sentences. Invoke with: /what"
---

# What

The user got distracted and needs a quick steer back into what we were doing. Give them a fast, concise re-orientation — no preamble, no recap of the whole session.

## Instructions

Look at the immediately preceding context (the last response and the current task in flight) and output:

1. **One or two sentences** describing where we are right now — what we were working on and the current state.
2. **One short line** naming the immediate next step, only if there's an obvious one in flight.

## Rules

- Keep it tight. This is a glance, not a status report. Aim for ~1-3 lines total.
- Focus on the **most recent** thread of work, not the entire conversation history.
- Don't ask questions, don't re-explain decisions already made, don't list options.
- Write in plain language as if catching a colleague back up after they stepped away.
- If there's genuinely nothing in flight (fresh session, no prior task), say so in one line and ask what they'd like to do.

## Example output

```
We just switched the PHP LSP from phpactor to intelephense in the Neovim config.
Next: verify it loads cleanly when you open a PHP file.
```
