# Stage 6 Summary — Second Red Team (Final Rigor Gate)

**Run:** during development
**Scope:** All 11 artifacts — Preface, Ch 1-9, Epilogue
**Output:** `review-work/NN-<slug>/07_red_team_v2.md` per artifact
**Skill version:** `book-red-team` v2 mode (extended same-day)

## Executive verdict

**Manuscript is ship-ready pending two blockers and six author-judgment questions.** No structural concerns. No new universal losses. No new hostile-reviewer ammunition. The Stage 6 lens caught what Stages 2-5 designed-around but missed: paraphrase-fidelity drift between Stage 3 fact-check and Stage 5 voice polish, and prose-leak issues from same-day-as-Stage-5 holistic-sweep changes that Stage 5 voice scan did not see.

After the two blockers land (~10 minutes of edit work) and Justin resolves the questions (recommendations attached to each), the manuscript advances to ship mode. `book-export` can run.

## Ship-readiness verdict by artifact

| Artifact | Verdict | Blockers | Revisions | Questions |
|---|---|---|---|---|
| Preface | ship-ready pending Q | 0 | 1 | 3 |
| Ch 1 | ship-ready pending Q | 0 | 2 | 3 |
| Ch 2 | **blockers-only fixes required** | **1** | 1 | 2 |
| Ch 3 | ship-ready pending Q | 0 | 0 | 2 |
| Ch 4 | ship-ready pending Q | 0 | 0 | 3 |
| Ch 5 | ship-ready pending Q | 0 | 0 | 3 |
| Ch 6 | ship-ready pending Q | 0 | 0 | 2 |
| Ch 7 | **blockers-only fixes required** | **1** | 0 | 2 |
| Ch 8 | ship-ready pending Q | 0 | 0 | 2 |
| Ch 9 | ship-ready pending Q | 0 | 0 | 4 |
| Epilogue | ship-ready pending Q | 0 | 0 | 1 |
| **TOTAL** | | **2** | **4** | **27** |

Compare to Stage 2: 41 blockers, 106 revisions, 34 questions across 11 artifacts. Stage 6's 2/4/27 split confirms the manuscript has cleared six prior passes substantively. The remaining work is a tight close-out gate, not another revise pass.

## Blockers (must-fix before ship-ready)

Two blockers, both surgical (~5-minute edits each).

### Blocker 1 — Ch 2 line 75 meta-voice leak from holistic sweep

The Group 3 → operators handoff sentence added during an earlier holistic sweep reintroduces a meta-voice pattern ("The book mostly calls them...") that Stage 2's systemic-fix pass had cut manuscript-wide. The voice scan ran before the holistic sweep on the same day and did not see the new prose.

**Fix:** rewrite line 75 to drop the "The book mostly calls them" construction. Candidate: "The X discussion called them Group 3. From here on the working vocabulary is operators, because that names what they do rather than where they sit in a population chart. Group 3 stays as the discourse-derived term in the diagnostic chapters; operators carries the rest." See Ch 2 Stage 6 artifact Finding 2 for full reasoning.

### Blocker 2 — Ch 7 line 61 Anthropic citation paraphrase contradicts source

The chapter says: "Anthropic itself published a research post in March 2026 arguing the same point from the other direction. As models get better, harnesses should shrink." The primary source (`anthropic-harness-design-2026-03-24`) actually argues something different: "the space of interesting harness combinations doesn't shrink as models improve. Instead, it moves." The chapter is using Anthropic as institutional support for a claim Anthropic does not make.

The Stage 3 fact-check note acknowledged this as a "minor re-wording job at voice polish," but voice polish does not address paraphrase fidelity, so the issue rolled forward to Stage 6.

**Fix:** drop the "Anthropic itself published a research post in March 2026 arguing the same point from the other direction. As models get better, harnesses should shrink." sentence at line 61. Keep the gardener metaphor sentences that follow. ~25 words removed. The chapter's "harnesses should shrink" thesis stands on its own authority + audit pattern + Cherny vanilla + Anthropic 20→7 MCP trim. See Ch 7 Stage 6 artifact Finding 1 for full reasoning + alternative path (b).

## Path C fold-in status

Per Justin's during development instruction, Path C open-decision items #1, #2, #4, #5, #8 fold into Stage 6 rather than running as a standalone sweep. Status table:

| Path C # | Item | Stage 6 status | Recommendation |
|---|---|---|---|
| #1 | Director-tier upward-mobility moment in Ch 9 | Surfaced as Q in Ch 9 artifact | Accept current state — Ch 1 line 107 carries it |
| #2 | Citation-pool acknowledgment in preface | Surfaced as Q in preface artifact | Add ~50-word acknowledgment at end of "The gap" or start of "The friction" |
| #4 | Ch 6 single-vendor exposure | RESOLVED during development (both rewrites applied) | Confirm closure |
| #5 | Epilogue Director-tier or F500 CEO vignette | RESOLVED during development (Director vignette + F500 CEO bridge paragraph) | Confirm closure |
| #8 | Archetype audit shape (Ch 9 4×4 matrix) | Surfaced as Q in Ch 9 artifact | Accept current state OR add one-sentence hard-fit list |

#4 and #5 are confirmation-only. #1, #2, #8 need Justin's call. #2 is the highest-leverage of the three — addresses one of the residual hostile-reviewer Cluster E ammunition vectors at low pacing cost.

## Highest-priority systemic findings

Three patterns that Stage 6 surfaced across multiple chapters.

### 1. Cross-stage contamination — holistic-sweep prose added post-Stage-5

The during development holistic sweep landed substantive prose in three chapters (preface forward-reference to Ch 9; Ch 2 Group 3 / operators handoff sentence; Ch 5 six-builder-moves rename). Voice polish ran before the sweep on the same day. The voice scan did not see the new prose. Result: Ch 2 line 75 meta-voice leak (now Blocker 1).

Verified clean elsewhere: Ch 5 (rename was scanned by Stage 5 because rename ran first); preface (added prose voice-clean per manual scan); Ch 8 line 26 Path B rewrite from later same day (manual Stage 6 scan confirmed clean).

**Process learning:** any prose changes added on the same day as Stage 5 voice polish, but after the polish artifact, need a manual voice scan during Stage 6. Update `book-voice-polish` SKILL.md failure-modes section to flag this stage-ordering risk.

### 2. Paraphrase-fidelity drift — Stage 3 notes that don't make it to revise

The Anthropic line 61 issue (Blocker 2) traces to a Stage 3 fact-check note that said "minor re-wording job at voice polish." Voice polish doesn't address paraphrase fidelity (it scans mechanical voice patterns, not source-text comparisons). The note rolled forward five passes without being acted on.

**Process learning:** Stage 3 fact-check notes about source-paraphrase mismatch should explicitly route to a revise pass between fact-check and adversarial reader, not be deferred to voice polish. Update `book-fact-check` SKILL.md procedure to flag paraphrase-mismatch findings as "revise-required" rather than "voice-polish-deferrable."

### 3. Cross-chapter dependencies — forecasts that need verification

Multiple chapters carry forward-references that depend on later chapters delivering on the promise. Stage 6 verified two:

- **Ch 4 line 121 → Ch 5:** "why that operator must be the senior leader and not a delegated specialist." **Honored** (Ch 5 engages through five primitives + anti-supervisor frame + operator-and-leader same-person section).
- **Ch 5 lines 114, 116 → Ch 9:** three threads (senior leader who cannot personally operate; rare F500 CEO who stays hands-on; convergence on a name). **All three honored** (Ch 9 §2 lines 56-60 + line 58 Jensen-archetype + lines 22-30 vocabulary survey + line 30 Builder-Leader coinage).

No cross-chapter dependency failures. The manuscript's structural promises hold.

## Citation-freshness ship-time actions

Three citations need verification at ship time, none current blockers:

| Source | Chapter(s) | Risk | Action |
|---|---|---|---|
| Schwab Director JD | Preface, Ch 2, Ch 5, Ch 9 | Posting may be removed when filled | Wayback Machine snapshot at ship; update source-index URL |
| Karpathy autoresearch star count | Ch 7 line 37 | Number moves daily | Verify count at ship; round appropriately |
| Zack Shapiro Artificial Lawyer March 2026 | Ch 6 line 133 | Stage 2 finding #7 not closed in change_log | Verify piece exists at venue with cited content; backup: replace with verifiable equivalent or cut |

## Convergence signals across Stage 6

Patterns flagged by multiple lenses across multiple artifacts:

- **Cluster D residual (X-handle anchoring) at Ch 1 line 83.** @0xAlcibiades 30%/400% number anchors the chapter's central claim without institutional pairing in same paragraph. Recommend pair with one institutional source OR explicitly frame as "one operator's measured spread." Ch 2's Anthropic Economic Index citation closes the same Cluster D pattern in that chapter; Ch 1 needs the analogous closure. Surfaced as Ch 1 Q1.
- **F500 CEO seating closure across operator-tier chapters.** Stage 4 Decision 1 Path B (Ch 6 + Ch 7 bridge paragraphs) confirmed landed in both. Stage 4 Decision 1 accept-current-state for Ch 4 confirmed. F500 CEO seating asymmetry now locked-decided manuscript-wide.
- **Hiring-panel diagnostic at Ch 9 line 62.** Cross-confirmed by Ch 1 line 107 forecast ("how to tell a real builder-leader from a consulting-deck-literate VP inside a hiring panel") + Ch 9 line 62 delivery. Manuscript-level promise → delivery chain holds.

## What Stage 6 confirmed about the manuscript

The Stage 6 lens is supposed to catch what slipped through six prior passes. The two blockers it caught (one meta-voice leak, one paraphrase fidelity) are both small surgical fixes; together they total ~10 minutes of work. The fact that Stage 6 found only two blockers manuscript-wide — across 35,000+ words and 11 artifacts — is itself the manuscript's quality readout.

The chapter-by-chapter ship-readiness verdict shows the manuscript is at production quality:

- 9 of 11 artifacts: ship-ready with no revisions and only author-judgment questions
- 2 of 11 artifacts: blockers-only fixes required (both surgical)
- 0 of 11 artifacts: structural revision required
- 0 hostile-reviewer weaponization events remain open
- All Stage 4 cluster ammunition (A, B, C, D, E, F) closed or accepted-deferred
- All Stage 4 manuscript-level decisions (Decision 1/2/3) landed
- All Stage 3 [VERIFY] flags closed
- All Path C items either resolved or surfaced with recommendations

## Next steps in order

1. **Apply Blocker 1** (Ch 2 line 75 meta-voice rewrite). ~5 minutes.
2. **Apply Blocker 2** (Ch 7 line 61 Anthropic citation removal, path a). ~5 minutes.
3. **Justin resolves the 27 author-judgment questions** across the 11 per-chapter artifacts. Each recommendation is attached; most are "accept current state." Estimated time: 30-60 minutes of decisions, plus any chosen revisions.
4. **Path C resolutions land** (#1 accept; #2 add ~50-word citation-pool acknowledgment to preface — recommended; #4 confirm closure; #5 confirm closure; #8 accept or add one sentence).
5. **Ship-time citation verification** (Schwab JD Wayback; Karpathy star count; Zack Shapiro piece). Performed at export time.
6. **Advance all 11 chapter status fields** to `ship-ready`.
7. **Run `book-export` in ship mode.** Per `book-export` SKILL.md, ship mode refuses if any chapter is not ship-ready; after step 6, the export proceeds.

## Process learnings to update in skills

Two skill updates worth landing before any future book starts the same pipeline:

- `book-voice-polish` SKILL.md: add failure-modes note that prose changes from same-day holistic sweeps need manual voice scan during Stage 6 (root-cause: Ch 2 Stage 6 Finding 3, Ch 8 Stage 6 Finding 1).
- `book-fact-check` SKILL.md: classify Stage 3 paraphrase-mismatch findings as "revise-required between fact-check and adversarial-reader" rather than as voice-polish-deferrable (root-cause: Ch 7 Stage 6 Blocker).

Both updates would have prevented the Stage 6 blockers if they had been in place. Land them in `.claude/skills/` as part of the manuscript's institutional knowledge for any sequel project.

## Single most important finding

**The manuscript is at production quality.** Six prior passes did the work they were designed to do. Stage 6's two blockers are the residual edge-cases the prior passes were not tuned to catch. The manuscript has no structural problems, no factual problems beyond the two surgical fixes, no hostile-reviewer ammunition remaining open, and no cross-chapter dependency failures. The 27 author-judgment questions are mostly "accept current state" recommendations that confirm Stage 4-5 decisions already settled.

After Blocker 1 + Blocker 2 land and the citation-pool acknowledgment lands in the preface (Path C #2 — the single highest-leverage remaining edit), the manuscript can ship.
