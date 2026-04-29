# `book-platform-sweep/scripts/` — wrapper architecture

These scripts are **thin wrappers** around a separate, generalized skill called `topic-platform-sweep`. The book project glues `topic-platform-sweep` to its specific layout (chapter slug → research directory).

## What's in here

Each `*-sweep.sh` script (Perplexity, HN, Reddit, Grok, Gemini, Substack, etc.) is roughly:

```bash
#!/usr/bin/env bash
SLUG="$1"; shift
exec ${TOPIC_SWEEP_ROOT:-/path/to/topic-platform-sweep}/<platform>-sweep.sh \
  "${BOOK_ROOT:-$PWD}/research/${SLUG}" "$SLUG" "$@"
```

Two environment variables drive them:

- `BOOK_ROOT` — the root of your book project. Defaults to `$PWD` (run from book root).
- `TOPIC_SWEEP_ROOT` — the path to your `topic-platform-sweep` skill scripts directory. No default; must be set.

The `synth-chapter.sh`, `fetch-discovery-urls.sh`, and `url-summarize.sh` scripts follow the same pattern.

## What's NOT in here

The underlying `topic-platform-sweep` skill is not in this repo. It contains the actual platform-call logic for each search source (Perplexity API, Hacker News Algolia, Reddit JSON, Grok x_search, Gemini grounded search, Substack scraping, Firecrawl URL bodies). It's a separate, broader skill the author maintains for any topic-grounded research, not just the book.

## To use these wrappers on your own book

You have two paths:

1. **Build your own underlying sweep scripts** (recommended). Each platform has a public API or scrape pattern. Implement one `<platform>-sweep.sh` per platform that takes `(output_dir, slug, ...args)` and writes a Tier-1 raw research file. Set `TOPIC_SWEEP_ROOT` to wherever you put them.

2. **Skip the sweep wrappers entirely.** The `book-platform-sweep` SKILL.md describes the three-tier research pattern conceptually. You can run searches manually (paste-into-LLM, copy-results-to-file) and produce the same Tier-1 raw files by hand. Slower but works without any custom infrastructure.

## SKILL.md still tells you what to run when

The SKILL.md at the parent directory describes the full three-tier sweep, the file naming contract, the consolidation pass, and the floor (six raw files per chapter minimum). It assumes the underlying scripts exist; if you've gone with path 2 above, treat the SKILL.md as a runbook and execute the steps manually.
