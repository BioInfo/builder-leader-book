# Red Team v2 (Stage 6) — Chapter 7: Building Your Personal Harness

**Draft reviewed:** `chapters/07-building-your-personal-harness.md` (draft-3.1, 3,340 words)
**Run date:** during development
**Prior stages reviewed:** Stage 2 (`04_red_team.md`), Stage 4 (`05_adversarial_reader.md`), Stage 5 (`06_voice_polish.md`)

## Summary

- Total findings: 3
- Blockers (must-fix before ship-ready status): 1
- Revisions (should-fix, justify each): 0
- Questions for author (judgment calls + Path C fold-ins): 2
- Ship-readiness verdict: **blockers-only fixes required** — one paraphrase-fidelity fix on the Anthropic citation at line 61 needs to land before ship-ready status.

## The contrarian (Stage 6 calibration)

The vanilla-vs-moat reconciliation at line 23 closes the cross-chapter tension explicitly. The "what you actually build" section was restructured at Stage 4 to break the five-parallel-You-will openers. The "do not let the rig become your whole second brain" softening at line 119 closes the Practitioner flag about the prescription being too universal.

No new findings.

## The hostile reviewer (Stage 6 calibration)

Stage 4 declared this the cleanest chapter on hostile-reviewer ammunition (zero quotes flagged). The descriptive-operational content gives a hostile reviewer little surface to work with. Hostile is at engaged-but-skeptical with the lowest hostility in the manuscript.

No new findings.

## The sympathetic-but-skeptical operator (Stage 6 calibration)

The Cherny opener, the "describe what you want, not the path" Phil Schmid discipline at line 59, the audit procedure at lines 79-89, the rare-high-consequence-skill exception at line 113 ("security guardrails, compliance checks") — all operator-true. Stage 5 fixed seven monotony hits and both `genuinely` instances. Reads tight.

No new findings.

## The craft editor (Stage 6 calibration)

Section count: 6 (instinct trap / what you actually build / MCP paradox / audit / compound inflection / what not to build). Word count 3,340 within target. The Stage 4 systemic F500 CEO bridge at line 93 ("If you are not personally running the audit, the same procedure is a diagnostic...") closes the chapter's third Path C item (Stage 4 Decision 1 Path B for Ch 7, paired with Ch 6).

No new findings.

## The slipped-through

Six categories scanned. Two findings — one is a blocker.

1. **Citation paraphrase fidelity — Anthropic line 61.** The chapter says: "Anthropic itself published a research post in March 2026 arguing the same point from the other direction. As models get better, harnesses should shrink." **Problem:** The primary source (source-index `anthropic-harness-design-2026-03-24`, https://www.anthropic.com/engineering/harness-design-long-running-apps) argues something different. Per the source-index notes: "primary which says 'the space of interesting harness combinations doesn't shrink as models improve. Instead, it moves.'" The chapter paraphrases Anthropic as making the "harnesses should shrink" argument; the primary actually argues the opposite. **Severity:** blocker. The chapter is using Anthropic as institutional support for a claim Anthropic does not make. Cluster B pattern (assertion-as-evidence, this time with the specific source contradicting the assertion).

   The fix is small but mandatory. Two paths:

   (a) **Drop the Anthropic citation and rest on the chapter's own authority + audit-pattern evidence.** The "harnesses should shrink" thesis is the chapter's own. The audit discipline + Cherny vanilla + Anthropic 20→7 MCP trim already support it. The line 61 Anthropic citation is the only one that contradicts its actual source. Replace with: "The right mental model for the harness is not a library you are accumulating, but a garden you are tending. Some of what you plant stays. Most of it does not. The gardener who prunes regularly ends up with more than the one who never cuts anything." Keep the gardener metaphor sentences; drop the "Anthropic itself published" sentence. Net: ~25 words removed.

   (b) **Rewrite to accurately reflect the primary.** "Anthropic, in a March 2026 engineering post, made a related point from a different angle. The space of interesting harness combinations doesn't shrink as models improve; it moves. The operator who tracks model improvements is updating what they build, sometimes by deleting." This is technically more accurate but introduces a different framing (combinations move) than the chapter's main argument (harnesses shrink). Slightly weakens the rhetorical convergence with Cherny + Anthropic 20→7.

   **Recommend (a).** The chapter's argument is clean enough on its own; the Anthropic citation was nice-to-have institutional support that turns out not to support the specific point. Removing it strengthens fidelity at small cost.

2. **Citation freshness — Karpathy autoresearch star count (line 37).** "Karpathy's autoresearch repository... sits at more than fifty-six thousand stars on GitHub." Stage 2 finding #5 flagged this for verification (repo vs. file separation, which was corrected). The number itself moves daily as the repo accrues stars. **Proposed fix:** at ship time, verify current star count and round appropriately ("more than sixty thousand stars" or whatever the actual number is at ship time). Known-deferred ship-time action, not a current blocker.

## Path C fold-ins

### [PATH-C: open-decision-#5 prereq — RESOLVED during development]

Although Path C #5 (Epilogue F500 CEO vignette) is not directly applicable to Ch 7, the Stage 4 manuscript-level Decision 1 Path B (F500 CEO bridge in Ch 6 + Ch 7) is the locked-applied resolution that paired Ch 7 with Ch 6 on the F500 CEO seating cluster. Both chapters now have their bridge paragraphs (Ch 6 line 117, Ch 7 line 93). Confirmed in live chapter. **Status: closed.** No Stage 6 action.

## Cross-chapter contradictions (Stage 6)

None new. Ch 7's vanilla-vs-moat reconciliation explicitly engages Ch 4's harness-is-the-moat thesis. Cross-references at lines 25 (Ch 6 back-ref), 103 (Ch 8 forward-ref), 125 (Ch 8 forward-ref) all consistent post-renumbering.

## Recommendations

**Blockers:**

1. **Finding 1 / Blocker #1.** Apply path (a): remove the "Anthropic itself published a research post in March 2026 arguing the same point from the other direction. As models get better, harnesses should shrink." sentence at line 61. Keep the gardener metaphor sentences that follow. Net: ~25 words removed. The chapter's argument is unweakened; the citation contradicting its own source is closed. ~5-minute edit.

**Revisions:** none.

**Questions for author:**

2. **Q1 — Finding 1 path choice.** Path (a) drops the citation; path (b) rewrites to accurately quote Anthropic. Recommend (a). If Justin prefers keeping an institutional anchor, path (b) works but introduces "harness combinations move" framing that's slightly off-thesis.

3. **Q2 — Karpathy star count ship-time action (Finding 2).** Confirm verification at ship time. Recommend yes; small mechanical update.

## Ship-readiness verdict

**Blockers-only fixes required.** One blocker: the Anthropic line 61 paraphrase fidelity issue. After the ~5-minute path (a) edit, Ch 7 advances to `status: ship-ready`. Path C closure (F500 CEO bridge) is confirmed. Stage 4 + Stage 5 work landed cleanly. The chapter is otherwise the manuscript's lowest-hostility, most operator-credible artifact.

The Anthropic citation issue is the kind of finding Stage 6 is meant to catch — a Stage 3 fact-check note that flagged "minor re-wording job at voice polish" never actually closed because voice polish doesn't address paraphrase fidelity. Stage 6's slipped-through lens caught it. Process learning: Stage 3 notes about source-paraphrase mismatch should explicitly route to a revise pass between fact-check and adversarial reader, not be deferred to voice polish.
