# Red Team — Chapter 7: Building Your Personal Harness

**Draft reviewed:** `chapters/07-building-your-personal-harness.md` (draft-1, 2,814 words)
**Run date:** during development
**Supersedes:** Prior 04_red_team.md from during development (reviewed pre-renumbering under old Ch 8)

## Summary

- Total findings: 17
- Blockers: 4 | Revisions: 10 | Questions: 3

## The contrarian

1. **Passage:** "Boris Cherny helped build Claude Code at Anthropic... His setup is surprisingly vanilla" (opener). **Problem:** Cherny's vanilla setup is an argument from authority that cuts against the book's own harness-is-the-moat thesis. Ch 4: the harness is the differentiator. Ch 7: keep it vanilla. A contrarian reads these as in tension. **Fix:** Reconcile. "The harness is the moat, but the moat is in what the harness fits — not how much is in it. Cherny's vanilla setup is still a harness; it just isn't a maximalist one." Name the tension, resolve it.

2. **Passage:** "Anthropic's own official MCP reference server collection was trimmed from twenty servers down to seven" (instinct-trap section). **Problem:** Trimming an official showcase ≠ trimming personal harnesses. Different decisions conflated. **Fix:** "Anthropic trimmed for pedagogical clarity. Your trimming is for operational clarity. The underlying principle — fewer, sharper — is the same. The motivation differs."

3. **Passage:** "Boring is a compliment in this phase" (audit section). **Problem:** For the book's executive-reader tier, "boring" undercuts motivation. The book spends Chapters 1-5 selling the harness as transformative; Ch 7 asks the reader to settle for vanilla. **Fix:** Replace "boring" with "unflashy" or "quiet." "Quiet is a compliment in this phase. Quiet means the rig has stopped being a project and started being a tool." Preserves the point without the demotivating register.

## The hostile reviewer

4. **Passage:** "Operators on Reddit have started calling the MCP tax... Three different threads on r/ClaudeCode" (instinct-trap section). **Problem:** r/ClaudeCode is a narrow technical community, not a representative sample for an executive-reader audience. Hostile reviewer: "who are these operators and why should a VP trust their community's conclusions?" **Fix:** Soften attribution or add a second-source anchor. "The pattern shows up on r/ClaudeCode and in LinkedIn posts from operators outside the subreddit — Koh, Cherny, Schmid, and others have described the same audit cycle."

5. **Passage:** "Karpathy's CLAUDE.md, a single file... north of fifty-six thousand stars on GitHub" (instinct-trap section). **Problem:** Factual claim: CLAUDE.md is a file inside a repo; the repo gets stars, not individual files. The "fifty-six thousand stars" attribution is mismatched. **Fix:** Verify — likely the claim should be "Karpathy's autoresearch repository, containing a CLAUDE.md file that has become widely-copied, sits at 56K+ stars." Separates the file from the repo it lives in. **BLOCKER** pending verification.

6. **Passage:** "Anthropic itself published a research post in March 2026 arguing the same point from the other direction. As models get better, harnesses should shrink" (skill-writers section). **Problem:** Specific research-post claim. Fact-check. Is this a real Anthropic research post or a paraphrase of informal messaging? **Fix:** Cite title/URL or soften to "Anthropic has argued, in recent publications, that..." **Question for fact-check.**

7. **Passage:** "Melody Koh, a partner at NextView Ventures who wrote one of the most-read LinkedIn posts on this phase in early 2026" (what-you-build section). **Problem:** "Most-read" is an unverifiable superlative. **Fix:** "...wrote a widely-circulated LinkedIn post on this phase in early 2026" or cite impression count.

## The sympathetic-but-skeptical operator

8. **Passage:** "Expect to delete forty to sixty percent of what you have accumulated. The number is surprisingly consistent across the operators who have published their audit experiences" (audit section). **Problem:** How many operators? "Surprisingly consistent" without n. **Fix:** "...consistent across the dozen or so operator writeups I've seen published in early 2026" — quantify the sample.

9. **Passage:** "Operators who post harnesses they have kept pruned over multiple audits consistently describe their month-fifteen setup as looking much like their month-three-audit setup" (audit section). **Problem:** Month-fifteen is past the book's six-month ceiling. Operators posting month-fifteen are a small self-selected sample. **Fix:** Soften or use a closer-in timeframe — "month-ten" or "approaching a year." The claim stays, the sampling gets more honest.

10. **Passage:** "MCP Tool Search... shipped in early 2026... The bloat economy for MCP is shifting toward additive" (MCP paradox section). **Problem:** Technical claim about a specific feature. Operator asks: is MCP Tool Search a default-on feature or opt-in? Does it eliminate the context-loading cost entirely or reduce it? Level of detail matters. **Fix:** Add one clause on what MCP Tool Search actually does mechanically — "lazy-loads tool descriptions on demand rather than eagerly at session start" covers it but the current passage only describes the effect. **Good enough** — low priority.

11. **Passage:** "A skill that fires twice a week is paying back. A skill that has fired three times in eight weeks is a candidate for deletion" (what-not-to-build section). **Problem:** Operator-true but oversimplified. Some skills fire rarely but are load-bearing when they do (compliance-check, security-audit). **Fix:** Add an exception — "The exception is high-consequence rare skills — security guardrails, compliance checks. Those earn their place even at once-a-quarter frequency."

## The craft editor

12. **Issue:** 6 section headers + "A turn" pattern repeats.

13. **Issue:** Chapter does not explicitly deliver the outline promise "by the end of this chapter, the reader has shipped something" (per `outline.md` line 82). **Problem:** The chapter focuses on subtraction/audit rather than a shipping moment. Outline said chapter ends with shipped artifact. **Fix:** Add a concrete shipping-moment paragraph near the compound-inflection section. "Somewhere in the same window — week eight or nine — you ship something through the rig that you would not have shipped without it. It is not a product launch. It is a real artifact your work required: a memo, a dataset, a decision framework, a working prototype. The rig becomes useful at the moment it produces something you actually use for work outside itself. Before that moment, it is scaffolding; after it, it is infrastructure." **BLOCKER** for outline fidelity.

14. **Issue:** Five primitives absent. Per craft-notes risk, Ch 7 should echo the primitives — the audit discipline is Judgment + Systems applied to the harness itself. **Fix:** In the audit section, add one sentence: "The audit is the five primitives turned inward: Systems thinking applied to the harness as a feedback system, Judgment applied to each component's earned place." Reinforces the primitives without re-teaching them. **Question for author.**

## Cross-chapter contradictions

15. **Stale cross-reference.** Line 93: "Chapter 9 picks this up" and line 117: "Chapter 9 is what happens when the second person joins your rig." Post-renumbering, the team-chapter is **Ch 8**, not Ch 9. ROADMAP claimed Ch 6-ref was fixed in Stage 1 audit, but Ch 9 → Ch 8 fixes were missed. **Fix:** Update both references to Chapter 8. Same pattern as Ch 6 findings #12, #13. **BLOCKER.**

16. **"The harness is the moat" vs "vanilla setup" tension** — cross-chapter dialog with Ch 4. Already flagged in finding #1.

17. **"Vanilla" language — inconsistent with "pruning is compounding."** Cherny's setup is "vanilla"; Chapter 7's argument is that pruning compounds. These are compatible but the chapter could make the link cleaner. **Fix:** "Cherny's vanilla setup is what a disciplined harness converges toward, not what it starts as. The vanilla you see at month twelve is the output of audits, not a starting point."

## Promise / delivery alignment

Per outline Ch 7:
- First month (weeks 2-6) ✓
- What to add and when ✓
- Discover skills by noticing repetition ✓
- Memory without overengineering ✓
- When to spawn an agent ✓
- Harness starting to pay back ✓ (compound inflection section)
- Concrete milestones ✓
- **By end, reader has shipped something: ✗ MISSING** (finding #13)

## Recommendations

**Blockers:**
1. Finding #15 — Update stale Ch 9 → Ch 8 cross-references
2. Finding #13 — Deliver the outline's "reader has shipped" promise
3. Finding #5 — Verify Karpathy 56K stars attribution (repo vs file)
4. Finding #1 — Reconcile vanilla-setup vs harness-is-moat tension (cross-chapter dialog)

**Revisions:** Findings #2, #3, #4, #6, #7, #8, #9, #11, #12, #14, #16, #17.

**Questions for author:**
- Finding #14: five-primitives nod in the audit section, yes or no?
- Finding #6: verify the Anthropic "harnesses should shrink" research post
- Finding #10: add mechanical detail on MCP Tool Search or keep it at effect-level?

**Convergence signals:**
- Stale cross-references across Ch 6 + Ch 7 — systemic renumbering pass required
- ROADMAP accuracy — Stage 1 audit wasn't fully applied; ROADMAP overstates what landed
- Outline-promise gap on "shipped something" (finding #13) — fidelity check
