# Production stats

A single page summarizing what went into producing *Builder-Leader: The AI Exoskeleton That Crosses the Gap*.

The book ships at 33,673 words across 11 manuscript artifacts (preface, nine chapters, epilogue), assembled into a 120-page typeset PDF and a structurally-clean EPUB.

## Manuscript

| Metric | Count |
|---|---|
| Manuscript artifacts (preface + 9 chapters + epilogue) | 11 |
| Total words | 33,673 |
| Final PDF | 120 pages |
| EPUB | 76 KB, single-file body |
| Status field on every artifact at ship | `ship-ready` |

| Chapter | Words |
|---|---:|
| Preface | 1,784 |
| 1 — Two Groups Speaking Past Each Other | 3,887 |
| 2 — What You See From the Other Side | 4,138 |
| 3 — Why Your Org Can't Cross Institutionally | 2,764 |
| 4 — The Harness and What's In It | 3,396 |
| 5 — The Builder Inside | 3,368 |
| 6 — Start With Claude Code | 3,513 |
| 7 — Building Your Personal Harness | 3,103 |
| 8 — From One Operator to a Team | 2,785 |
| 9 — Leading From the Other Side | 3,472 |
| Epilogue | 1,463 |

## Research

| Metric | Count |
|---|---:|
| Per-chapter research findings files | 11 |
| Raw research files (Tier-1 platform sweeps + Tier-2 discovery) | 117 |
| Total lines of raw research material | 28,282 |
| Unique citation keys in master source-index | 30+ |
| Claims tracked in claims-to-verify queue | 363 lines |
| Claims promoted to verified-claims | 108 lines |

Research floor enforced by `book-platform-sweep`: at least six raw research files per chapter, sourced across Perplexity, Hacker News (with comment bodies), Reddit (with post bodies), Grok x_search, Gemini grounded search, and a shared Substack pool. Discovery sweep ("surprise me") plus per-URL body extraction layered on top.

## Rigor pipeline

The book passed nine sequential stages.

| Stage | Pass type | Per-chapter artifact | Manuscript-wide summary |
|---|---|---|---|
| 1 | Research | `research/<ch>/findings.md` | — |
| 2 | Draft | `chapters/NN-<slug>.md` | — |
| 3 | Stage 2 red team (structural + adversarial) | `04_red_team.md` | `STAGE_2_SUMMARY.md` |
| 4 | Fact-check (assertion registry) | `01_assertion_registry.md` | — |
| 5 | Adversarial reader (multi-persona) | `05_adversarial_reader.md` | `STAGE_4_SUMMARY.md` |
| 6 | Voice polish (mechanical + judgment) | `06_voice_polish.md` | `STAGE_5_SUMMARY.md` |
| 7 | Stage 6 red team (final rigor gate) | `07_red_team_v2.md` | `STAGE_6_SUMMARY.md` |
| 8 | Close-out (apply blockers, resolve questions, advance status) | inline | — |
| 9 | Ship-time citation verify | inline + Wayback | — |

| Metric | Count |
|---|---:|
| Per-chapter rigor artifacts | 55 (5 stages × 11 chapters) |
| Manuscript-wide stage summaries | 4 |
| Total factual claims extracted across all chapters | 169 |
| Stage 6 (final gate) blockers caught after six prior passes | 2 |
| Stage 6 author-judgment questions surfaced and resolved | 27 |

## What this number is and isn't

These stats are the production trace of one book by one author working through the framework in this repo. They are **not** an estimate of how long any nonfiction book takes to produce. They are also not an estimate of how long this same book would have taken with a different harness, or no harness, or a team of human collaborators.

What they are: an audit trail. The book exists as a finished artifact, the framework is documented, and the production is reproducible by anyone willing to operate the same pipeline against their own manuscript.

The author bought the book at the table-stakes cost of any nonfiction project: research depth, judgment, rewrites, and time on his own keyboard reading what came back from the harness and deciding what to keep, what to cut, what to rewrite. The harness made the typing faster. The judgment was still his.
