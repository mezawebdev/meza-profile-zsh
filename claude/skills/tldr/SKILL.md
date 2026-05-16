---
name: tldr
description: Compress your most recent response into a TL;DR plus numbered key points. Use when the user invokes /tldr to condense a wall of text. Accepts an optional argument — a number caps bullet count, or "headers" reformats as section headers instead of a numbered list.
disable-model-invocation: true
---

Compress your own most recent assistant response (the one immediately before this invocation) into a condensed version.

## Output format

Default:

1. A 1–2 sentence TL;DR at the top (no "TL;DR:" label needed — just the sentences).
2. A numbered list of the key points, decisions, claims, or recommendations — one line each, no sub-bullets.
3. Nothing else. No preamble, no "let me know if you want more detail," no closing remarks.

## What to preserve

Keep anything load-bearing:
- Specific numbers, thresholds, versions
- File paths, command names, flags
- API signatures, function/variable names
- Version constraints, compatibility notes
- Explicit recommendations ("use X, not Y")

## What to drop

- Throat-clearing and restated context
- Caveats that don't change the action
- Illustrative examples that only reinforce a point already made
- Hedging language when the original already committed to a position

## Code blocks

If the original contained code blocks, do not include them in the summary. Instead, append `(code omitted — see original)` to the point that referenced the code.

## Arguments

The skill may be invoked with an argument:

- **Number** (e.g. `/tldr 3`) — cap the numbered list at that many bullets. Merge or drop lower-priority points to fit.
- **`headers`** (e.g. `/tldr headers`) — replace the numbered list with short section headers (`##` level), each followed by one line of content. Keep the TL;DR at the top.
- **No argument** — use the default numbered format.

## Constraints

- Target the *most recent assistant response*, not the entire conversation.
- If the previous response was already short (under ~5 lines), say so in one sentence and stop — do not pad.
- Do not invent content that wasn't in the original.
