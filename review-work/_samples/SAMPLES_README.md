# Sample review-work artifacts

These are real rigor-pipeline artifacts from one chapter of the book — Chapter 7, *Building Your Personal Harness* — plus the manuscript-wide ship-day summary. Chapter 7 was chosen because its source material is already public-facing (see `research/_samples/SAMPLES_README.md`).

Every chapter in the book has all five per-chapter artifacts below. The full set across 11 manuscript artifacts is held in the author's private working repo.

## What's here

### Per-chapter (one chapter, Ch 7)

- `07-building-your-personal-harness/01_assertion_registry.md` — **Stage 3 fact-check.** Every factual claim in the chapter, classified SOURCED / PARTIAL / UNSOURCED / DRIFT, traced to a research entry. Produced by the `book-fact-check` skill.
- `07-building-your-personal-harness/04_red_team.md` — **Stage 2 red team.** Structural and adversarial critique. Weak arguments, unsupported load-bearing claims, counter-positions not engaged. Produced by `book-red-team` (Stage 2 mode).
- `07-building-your-personal-harness/05_adversarial_reader.md` — **Stage 4 multi-persona reader.** The chapter is read by the actual audiences it's written for: an in-position senior leader, an aspiring leader, a Fortune 500 CEO reader, and a hostile reviewer who disagrees with the book's thesis. Each persona's critique is captured. Loop until critiques converge. Produced by `book-adversarial-reader`.
- `07-building-your-personal-harness/06_voice_polish.md` — **Stage 5 voice polish.** Mechanical scan (em-dashes, banned words, sentence-length monotony, paragraph rhythm, banned constructions, heavy-use content-word frequency) plus per-hit Opus judgment. Each fix logged. Produced by `book-voice-polish`.
- `07-building-your-personal-harness/07_red_team_v2.md` — **Stage 6 second red team.** Final rigor gate before export. Looks specifically for what slipped through the prior six passes. Produced by `book-red-team` (Stage 6 mode).

### Manuscript-wide

- `STAGE_6_SUMMARY.md` — the manuscript-wide summary written at ship time. Aggregates Stage 6 findings across all 11 chapters. Captures cross-chapter dependencies, blockers applied, author-judgment questions resolved, and the overall ship verdict.

## What's not here

Two artifacts that exist per chapter in the private repo but are not included in the public sample:

- `02_data_verification.md` — quantitative claim cross-check against source data. Intentionally redundant with `01_assertion_registry.md` for chapters that don't carry heavy quantitative load.
- `03_structural_proposal.md` — argument structure and narrative-flow critique. For Ch 7 specifically, this artifact wasn't produced because the chapter was structurally clean from draft 1.

## How to read these as samples

If you're using the skills on your own writing: each artifact has a stable filename pattern and a stable internal format. Your own runs of `book-fact-check`, `book-red-team`, etc. will produce artifacts in the same shape. The numbered prefix (`01_`, `04_`, `05_`, `06_`, `07_`) corresponds to the rigor pipeline stage — see `README.md` at the repo root for the full pipeline.

If you're a reader curious about the production: the artifacts show how a chapter that looks clean on the surface was actually shaped by repeated critique. The `04_red_team.md` and `05_adversarial_reader.md` are the most revealing. They are what most published nonfiction does not show you.
