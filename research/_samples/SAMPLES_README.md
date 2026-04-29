# Sample research artifacts

These are real research artifacts from one chapter of the book — Chapter 7, *Building Your Personal Harness*. Chapter 7 was chosen because its source material (Andrej Karpathy's `autoresearch` repo, public X threads about AI harness patterns, public Substack discussion of personal AI workflows) is already public-facing, so nothing in these artifacts is proprietary.

Every chapter in the book has comparable artifacts. The full corpus is held in the author's private working repo.

## What's here

- `07-building-your-personal-harness/findings.md` — the consolidated research findings file the chapter was drafted against. This is the **synthesis** of the Tier-3 research pipeline: per-research-question, with citation keys against the raw sources.
- `07-building-your-personal-harness/_raw/README.md` — the inventory of raw research files for this chapter. The raw files themselves are not in the public repo (each is a multi-thousand-line dump from Perplexity, HN Algolia, Reddit JSON, Grok x_search, Gemini grounded search, etc.). The inventory shows you the depth: which platforms were swept, what each file covers.

## What it cost

Producing one chapter's research takes a single Tier-1 + Tier-2 + Tier-3 sweep via the `book-platform-sweep` skill. Wall-clock: 30-90 minutes depending on platform response times. The skill that ran this is in `.claude/skills/book-platform-sweep/`.

## Why share this

Two reasons. First, to demonstrate that the book's claims are grounded in a real research record, not generated. Second, to make the research-pipeline pattern transferable: anyone using `book-platform-sweep` on their own writing produces artifacts in the same shape, against their own canon and findings structure.

The sample is not the corpus. Buy the book if you want the rest.
