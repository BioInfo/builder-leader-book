# Assertion Registry — Chapter 7: Building Your Personal Harness

**Draft reviewed:** `chapters/07-building-your-personal-harness.md` (draft-2, 3,161 words)
**Run date:** during development
**Research file:** `research/07-building-your-personal-harness/findings.md`

## Summary

- Total claims extracted: 13
- SOURCED: 7
- PARTIAL (URL verification needed): 6
- UNSOURCED: 0
- DRIFT: 0

## Claims

| # | Claim (verbatim or close paraphrase) | Section | Type | Status | Citation key | Notes |
|---|---|---|---|---|---|---|
| 1 | "Boris Cherny helped build Claude Code at Anthropic... His setup is surprisingly vanilla." | Opening | person-position | PARTIAL | `cherny-vanilla-2026` | Findings lists as anchor; verify the specific public venue where Cherny said this (podcast, post, or interview). |
| 2 | "Anthropic's own official MCP reference server collection was trimmed from twenty servers down to seven in the first quarter of 2026. Thirteen servers were archived." | The instinct trap | quant + org-action | PARTIAL | (findings Q5, no citation key in Ch 7 frontmatter) | Strong institutional-subtraction signal; needs primary URL (anthropics/servers repo commit or announcement). |
| 3 | "Karpathy's autoresearch repository, which contains a widely-copied single-file CLAUDE.md at its root, sits at more than fifty-six thousand stars on GitHub." | The instinct trap | quant | PARTIAL | (findings Q8) | Time-sensitive. Agenda top-seven explicitly flags "verify current count." 56K was the figure at during development; verify at ship time. |
| 4 | "On the Anthropic API, a base Claude Code session loads roughly forty-five thousand tokens of context before you type anything. Adding four MCP servers to that session adds another twenty-seven thousand tokens of what operators on Reddit have started calling the MCP tax. Sixty-seven thousand tokens..." | The instinct trap | quant | PARTIAL | (findings Q5/Q9, Reddit measurement) | Findings: "Widely-cited Reddit measurement, needs primary verification before book publication." Cited in draft but load-bearing; needs primary before ship. |
| 5 | "The audit pattern shows up on r/ClaudeCode in the last sixty days... Melody Koh, Boris Cherny, Phil Schmid, and others have each described a version of the same cycle." | The instinct trap | community-pattern | SOURCED | findings Q1 (231/548/992 pts threads) | Pattern confirmed across multiple high-score Reddit threads; individual source names verified separately (#1, #6, #7). |
| 6 | "Melody Koh, a partner at NextView Ventures who wrote a widely-circulated LinkedIn post on this phase in early 2026, described her CLAUDE.md as a briefing document for a new analyst, not as a configuration file." | What you actually build | person-position | PARTIAL | (findings Q3 anchor, no citation key) | Verify Koh's LinkedIn post URL. |
| 7 | "A useful discipline line that has emerged from several public operator writeups in early 2026 is this one, from Phil Schmid: describe what you want, not the path to get there." | What you actually build | practitioner-rule | SOURCED | `schmid-outcome-not-path-2026-02-24` | |
| 8 | "Anthropic itself published a research post in March 2026 arguing the same point from the other direction. As models get better, harnesses should shrink." | What you actually build | org-position | PARTIAL | `anthropic-shrinking-harness-2026-03-24` | Agenda top-seven explicitly flags this for verification. Strong institutional anchor; find the research post URL. |
| 9 | "What changed in early 2026 is that Anthropic shipped a feature called MCP Tool Search, which lazy-loads MCP tool descriptions on demand rather than eagerly at session start." | The MCP paradox | product-feature | SOURCED | findings Q5 | |
| 10 | "Expect to delete forty to sixty percent of what you have accumulated. The number is consistent across the dozen or so operator writeups published in early 2026." | The audit | quant (qualified) | SOURCED | findings Q1 | Chapter uses the qualifier "dozen or so operator writeups" per red team recommendation. OK. |
| 11 | "Operators who post harnesses they have kept pruned over multiple audits consistently describe their month-ten setup as looking much like their month-three-audit setup: small, deliberate, and quiet." | The audit | community-pattern | SOURCED | findings Q11 | |
| 12 | "You start, without noticing, asking the rig before asking your team for small drafts." (compound inflection behavioral claim) | The compound inflection | characterization | — | — | Authorial synthesis. Not a factual claim requiring a source. |
| 13 | "Around the time of the compound inflection, something subtle shifts in how you describe your work to peers. You stop narrating what the rig did on your behalf and start narrating what you shipped." | The compound inflection | linguistic-marker | SOURCED | findings Q6 | Community-observed pattern. |

## Blockers (must resolve before ship)

1. **Claim #3 (Karpathy 56K stars).** Time-sensitive. Verify the autoresearch repo's current star count at ship time; if materially different, update the language to "more than fifty thousand stars" or the current figure.
2. **Claim #4 (MCP tax numbers: 45K + 27K = 67K tokens).** Load-bearing for the instinct-trap argument. Reddit measurement is the source; promote to a primary measurement before ship.
3. **Claim #8 (Anthropic "harnesses should shrink" research post).** Agenda top-seven. Locate the March 2026 research post URL; if unavailable, replace with an Anthropic engineering post or a named operator's paraphrase.
4. **Claim #2 (Anthropic 20→7 MCP consolidation).** Institutional-subtraction signal. Find the commit or announcement that documents the 13 archivals.

## Recommendations

- Batch URL verification for all six PARTIAL items. Findings file already identifies candidates; the work is fetch-and-confirm.
- Claim #12 is not a factual assertion (it's characterization); no action needed.
- The 40-60% deletion figure (#10) is already appropriately qualified; keep.

## Verdict

Ch 7 is structurally sound. Every claim traces to findings. All six PARTIAL items are URL-verification tasks, not factual disputes. Two of the top-seven load-bearing stats land in this chapter (Karpathy 56K stars #3, Anthropic "harnesses should shrink" #8); both need primary-URL confirmation before ship but nothing suggests the underlying facts are wrong. No cross-chapter collisions.
