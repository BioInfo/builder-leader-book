---
date: during development
slug: stage-6-closeout-and-ship
session_type: close-out gate + ship
duration: ~1.5 hours
---

# Session during development — Stage 6 Close-Out + Ship

## What this session was

The close-out gate before `book-export` ship mode. Stage 6 had landed two surgical blockers + 27 author-judgment questions across 11 artifacts. This session applied the blockers, walked the questions, advanced all 11 chapter status fields to `ship-ready`, and ran `book-export` in ship mode.

## Edits applied

Five prose edits, all surgical.

### Blocker 1 — Ch 2 line 75 meta-voice rewrite

**Reason:** an earlier holistic sweep introduced "The book mostly calls them operators going forward," reintroducing a meta-voice pattern Stage 2 had cut manuscript-wide.

**Fix:** rewritten as a stipulative assertion — "From here on the working vocabulary is operators, because that names what they do rather than where they sit in a population chart. Group 3 stays as the discourse-derived term in the diagnostic chapters; operators carries the rest."

The handoff substance survives, the meta-voice is gone.

### Blocker 2 — Ch 7 line 61 Anthropic citation removal

**Reason:** the chapter paraphrased Anthropic's March 2026 harness-design post as arguing "harnesses should shrink." The primary source argues something different ("the space of interesting harness combinations doesn't shrink as models improve. Instead, it moves"). Stage 3 fact-check had flagged this as a "minor re-wording job at voice polish," but voice polish doesn't address paraphrase fidelity, so the issue rolled forward.

**Fix:** dropped the "Anthropic itself published a research post in March 2026 arguing the same point from the other direction." sentence. The gardener metaphor sentences kept. ~25 words removed. The chapter's "harnesses should shrink" thesis stands on the audit-discipline pattern + Cherny vanilla + Anthropic 20→7 MCP trim.

### Preface revision #1 — drop redundant audience-scoping clause

Line 49's "which is most senior executives who are not running a Fortune 500 themselves" duplicates audience-scoping work the Schwab/Gartner paragraph already does upstream. Cut. Section now closes on "The climb is available to any leader whose surface and density match." — rhythmically stronger.

### Preface Path C #2 — citation-pool acknowledgment

Stage 4 had flagged the absence of a citation-pool acknowledgment as a Cluster E hostile-reviewer ammunition vector. Highest-leverage remaining edit per Stage 6 summary.

**Added** at the end of "The gap" section (between line 49 and the "## The friction" header):

> The book draws heavily from a coherent intellectual tradition. Karpathy, Mollick, Fowler, Anthropic's research posts, the operator community on X and HN. That tradition is producing the work the book is documenting. Counter-traditions exist; they are engaged where they make load-bearing arguments.

~50 words. Voice-clean (em-dash converted to period, no banned constructions).

### Ch 1 Q2 framing fallback — line 83 @0xAlcibiades

**Reason:** Stage 6 Cluster D residual. The chapter's central claim about the inside-Group-2 spread anchors on a single X handle. Per the artifact's recommended fallback ("frame the number as 'one operator's measured spread'"), I applied the framing fix without sourcing the institutional pairing.

**Fix:** "@0xAlcibiades, replying to the same thread, put numbers on **one operator's measured spread**: a 30 percent gain of function from zero to prod, 400 percent from zero to prototype."

Hostile-reviewer ammunition closes; cost is zero.

### Ch 1 Revision 2 / Q3 — line 105 colon→period

The augmented-leadership signposting sentence carried a colon-clause that read dense on first pass. Path (b) applied: colon replaced with period; "diagnosis chapters / prescription chapters" replaced with explicit "Chapter 5 / Chapter 9." Tighter, more direct. The em-dash flag noted in the Stage 6 finding was already absent in the live prose (Stage 5 had handled it).

## Author-judgment questions — resolution

All 27 questions resolved. Three needed Justin's call; he answered "accept" on all three.

| Decision | Resolution |
|---|---|
| Ch 1 Q1 (non-coding-domain anchor at L55) | Accept assertion-as-bridge; subsequent chapters carry the load |
| Ch 6 Q1 (Zack Shapiro citation L133) | Keep with ship-time verification (added to citation-freshness list) |
| Ch 9 Q2 (archetype audit shape) | Accept current state; full 4×4 matrix stays as companion-site material |

The other 24 questions had clear "accept current state" recommendations from the Stage 6 artifacts and were confirmed without further author input. Each chapter's change_log entry documents the resolution.

## Status fields advanced

All 11 chapters now `status: ship-ready`. Word counts updated on the four chapters with prose changes (preface 1650→1780, Ch 1 4050→3890, Ch 2 4000→4140, Ch 7 3340→3315). `last_touched: during development` on all 11.

## Ship-time citation-verification list (carried)

Three citations to verify at ship time. None blocking; all known-deferred.

| Source | Chapter | Action |
|---|---|---|
| Schwab Director JD | Preface, Ch 2, Ch 5, Ch 9 | Pull Wayback Machine snapshot; update source-index URL |
| Karpathy autoresearch star count | Ch 7 line 37 | Verify current count; round appropriately |
| Zack Shapiro Artificial Lawyer March 2026 | Ch 6 line 133 | Verify piece exists at venue with cited content; backup: replace or cut |

These run at the next ship pass (e.g., before public release or paperback handoff). The current export is internal, so the action is parked.

## book-export ship mode

Ran cleanly.

```
Found 11 chapter files.
Ship mode: verifying every chapter has status=ship-ready...
All chapters ship-ready.
Assembled 1093 lines.
Building export/book.pdf ...

Done.
  Mode:       ship
  Chapters:   11
  PDF:        export/book.pdf (324K, 119 pages)
  Log:        export/.build.log
```

119 pages, 324K. The manuscript exists as a typeset PDF.

## What's still open

- **Ship-time citation verification** (the three deferred above) — runs on next ship pass.
- **Optional skill updates** from Stage 6 process learnings:
  - `book-voice-polish` SKILL.md: failure-modes note that prose changes from same-day holistic sweeps need a manual voice scan during Stage 6.
  - `book-fact-check` SKILL.md: classify Stage 3 paraphrase-mismatch findings as "revise-required between fact-check and adversarial-reader," not voice-polish-deferrable.
- **Distribution decisions** — publishing path (companion site, hardcover, ebook, audio) was deferred to late-stage. Ship PDF is the input to whichever path Justin chooses.
- **EPUB build** if needed: `./build.sh ship epub`.

## Process notes

- The Stage 6 design caught what it was supposed to catch. Two blockers across 35K words is the manuscript's quality readout.
- The Path C #2 citation-pool acknowledgment in the preface is the single highest-leverage remaining edit Stage 6 surfaced. Took ~50 words, closed a hostile-reviewer ammunition vector.
- All three Justin-decisions resolved as "accept current state," consistent with what the Stage 6 artifacts had recommended.
- Total session prose impact: ~10 minutes of edits + ~15 minutes of frontmatter updates + ~1 minute of ship build. The bulk of the time was reading Stage 6 artifacts and writing change_log entries.
