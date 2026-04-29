# Research — Chapter 8: Building Your Personal Harness

**Chapter role:** Months 1-3 of the six-month builder-leader ladder. Reader has done weeks 1-2 (Ch 7). Now moves from using a pre-built setup to building their own: skills, memory, subagents, hooks, MCP servers.

**Chapter draft:** `chapters/08-building-your-personal-harness.md` (draft-1, 2,814 words). Drafted during development from the consolidated research below. Research-reshaped thesis: **the month 1-3 arc is about subtraction**, not addition.

**Recency window:** preferred 3-month (since 2026-01-18), 6-month default (since 2025-10-18). Today: during development.

**Last research pass:** during development, full multi-platform sweep (X, Substack, HN+Reddit, LinkedIn+vendors, GitHub ecosystem) + Perplexity + Gemini Deep Research.

**Status:** drafted-research-complete. Chapter ready for fact-check + red-team revision. See `../../review-work/08-building-your-personal-harness/04_red_team.md`.

---

## The directional reshape

The original outline framed Ch 8 as the chapter where the operator adds skills, memory, subagents, hooks, MCP. The research surfaced a different truth. The month 1-3 phase IS the phase where those primitives get added, but the winning operators do not stay additive past week six or seven. The arc is:

1. Weeks 1-4: light addition. Write your first few skills. Add your first MCP. Set up one hook.
2. Weeks 5-8: notice what fires and what does not.
3. Weeks 9-12: the audit. Delete 40-60% of what has accumulated.
4. Month 4 forward: maintain via periodic pruning.

The chapter's thesis follows this arc but leads with the subtraction frame because that is the counterintuitive move for the reader coming in with additive instincts.

---

## Anchor candidates

- **Boris Cherny (Claude Code creator, Anthropic), 2026 — "my setup is surprisingly vanilla"** — Public comments on his own rig. The strongest authority move for the subtraction thesis because it comes from the person who built the tool. Used as cold-open in draft-1. Citation key: `cherny-vanilla-2026`.
- **Kieran Klaassen, "The Folder Is the Agent"** (Every, during development) — running 44 folder-based agents; abandoned swarm orchestration at month 3. Alternative cold-open candidate. Citation key: `klaassen-folder-is-agent-during development`.
- **Phil Schmid, "describe what you want, not the path"** (2026-02-24) — durable skill-writing rule. Cited in draft-1. Citation key: `schmid-outcome-not-path-2026-02-24`.
- **Cobus Greyling, "context is a budget, not a log"** (2026 early) — memory-section upgrade. Citation key: `greyling-context-budget-2026`.
- **Anthropic research post** (2026-03-24) — "harnesses should shrink as models improve." Institutional endorsement of the subtraction thesis. Cited in draft-1. Citation key: `anthropic-shrinking-harness-2026-03-24`.
- **Seth Gammon, "From Zero to Fleet"** (r/ClaudeCode, 2026-03-23, 142 pts) — five-level ladder (Raw → CLAUDE.md → Skills → Hooks → Orchestration). Nearly identical arc to Ch 8. Citation key: `gammon-zero-to-fleet-2026-03-23`.

---

## Findings by research question

### Q1. Month 1-3 operator discourse

- **"The audit" is the emerging narrative shape of month 3.** Three separate high-score Reddit threads (231, 548, 992 pts) are structurally identical: slowdown → audit → 40-60% removed. This is not one person's pattern; it is the community pattern.
- **Personal-harness vocabulary is ~90 days old** in mainstream discourse per Perplexity synthesis. The book can claim the phase and canonize its vocabulary.
- **Klaassen's "abandoned swarm orchestration at month 3"** matches the subtraction arc exactly.

### Q2. Skill-writing patterns

- **Schmid's "describe what you want, not the path"** — durable rule; skills that specify outcome age well, skills that specify steps age poorly.
- **Thariq, "skill is a folder, not a file"** — conceptual pivot from earlier; skills as structured directories with subfiles. The chapter does not yet engage this; flagged for draft-2.
- **Raduan, "most external skills are pure slop"** — month-3 reckoning from a sharp operator voice.
- **Vercel's AGENTS.md counter-position** (HN 524 pts) — some operators argue AGENTS.md outperforms skills. Steel-man position.

### Q3. Memory and context architecture

- **Melody Koh, "CLAUDE.md is a briefing doc, not a config file"** — reframes what memory is for. Cited in draft-1.
- **Anthropic's own engineering post on harness design** (2026-03-24) — harnesses should shrink as models improve.
- **Greyling's "context is a budget, not a log"** — the frame that turns memory from accumulation into optimization.

### Q4. Subagent / parallelization

- **Premature fan-out is the universal month-2 anti-pattern.** Community threads across r/ClaudeCode + HN consistently describe new operators adding subagents before feeling the limit of serial work.
- **Claude Code 2.1.101 shipped `/team-onboarding`** (during development) — auto-generates team ramp-up guides from local usage. Month-3 harnesses now export themselves. Natural handoff to Ch 9.

### Q5. MCP server adoption

- **45k-token base Claude Code payload + 27k-token MCP tax for 4 servers** = 67k standing cost before any work begins. Widely-cited Reddit measurement, needs primary verification before book publication. Cited in draft-1.
- **Anthropic's official MCP reference server collection was trimmed from 20 → 7** in Q1 2026 (13 archived). Strong institutional-subtraction signal.
- **MCP Tool Search / lazy loading** (Anthropic, 2026) — changes the calculus. MCP installs now cheap; skill installs still expensive. The bloat economies are different and the chapter now distinguishes them.
- **MCP directories:** pulsemcp.com (live), mcpservers.org (live), mcp.so (403'd). Ecosystem consolidating.

### Q6. Compound inflection

- Operators consistently describe **the week-seven-to-eleven shift** — the moment the rig stops feeling like a tool being configured and starts feeling like a working partner. The chapter narrates this directly.
- **Linguistic marker of transition:** operators stop narrating what the rig did and start narrating what they shipped. Added to draft-1.

### Q7. Anti-patterns

Documented in 2026 discourse:

- Skill bloat
- MCP tax / MCP graveyard
- "Install on pain" — adding tools only after failure, which works but leads to inconsistent coverage
- Over-elaborate CLAUDE.md (violates single-file-wins pattern)
- Copying another operator's setup wholesale
- Premature subagents
- Treating the rig as second-brain / memory palace

### Q8. GitHub ecosystem

- **Ecosystem is consolidating at the protocol layer** (anthropics org, modelcontextprotocol org, shared registry governance with PulseMCP/GitHub/Stacklok).
- **Fragmenting at the user-setup layer** (5 competing "awesome-claude-skills" repos each with 10k+★).
- **anthropics/skills** — 119,848★, the spec owner, created 2025-09-22.
- **Karpathy's single-file CLAUDE.md** — ~56k★, beats elaborate frameworks on adoption. Strongest evidence for the simplicity-wins argument.
- **Operator-setup category mainstream:** gstack 75k★, affaan-m 160k★, claude-mem 61k★. slopless is mid-pack; not niche.
- **Skills-over-MCP working group** (experimental-ext-skills) is actively merging the two primitives.

### Q9. Cost and infrastructure

- **MCP tax is the dominant line item** in engaged-operator token spend.
- **Anthropic Economic Index "Learning Curves" report (March 2026)** — long-tenure Claude users (6+ months) show 7 percentage points higher work usage and 10% higher success rates. This is the quantified builder-leader thesis in Anthropic's own data. Flagged for further mining before publication.
- **Faros DORA data** — published individual-vs-organization productivity gap numbers that map to the builder-leader thesis. Need specific figures.

### Q10. The builder-leader reshape question

- **Managed Agents does not replace the personal harness; it validates it as the meta-harness.** Anthropic's own engineering post frames Managed Agents as "unopinionated about the specific harness Claude will need in the future." Operator's harness moves up the stack.
- **Cline's "Architects or Tenants" (during development)** — the anti-Managed-Agents argument in the wild. Worth steel-manning in Ch 10 when the broader leadership question lands.
- **"Builder-leader" zero LinkedIn footprint** as of April 2026 — the book can claim the term.

### Q11. Harness evolution over time

- Operators who post month-15 harnesses consistently describe setups that look much like the month-3-audited version: small, deliberate, "boring." Boring is the compliment in this phase.
- Karpathy's single-file CLAUDE.md is the paradigmatic case — one file that has compounded over time via pruning, not accumulation.

---

## Novel angles absorbed in draft-1

- Cherny "vanilla" cold-open
- Anthropic 20 → 7 MCP subtraction
- Karpathy 56k★ single-file
- Koh "briefing doc" reframing
- Schmid "outcome not path" rule
- Anthropic 2026-03-24 "harnesses should shrink" institutional endorsement
- The month-three audit pattern (narrative shape + 40-60% deletion)
- MCP tax quantification (45k + 27k = 67k)
- MCP Tool Search inversion (MCP cheap, skills not)
- Compound inflection narrative
- Linguistic-transition marker (narrate-what-you-shipped)

## Pending for draft-2

- Thariq "skill is a folder, not a file" conceptual pivot
- Raduan "external skills are slop" month-3 reckoning quote
- Vercel AGENTS.md counter-position
- Anthropic Economic Index Learning Curves specific figures
- Faros DORA specific numbers
- /team-onboarding command explicit mention (bridging to Ch 9)

---

## Open

Items requiring resolution before Ch 8 ships:

- **Primary sources for all quantitative claims** (red team blocker #1): 67K token tax, 27K 4-MCP load, 45K base payload, 20 → 7 MCP consolidation before/after, Karpathy 56k★ count. Most are in community threads; need authoritative measurements.
- **"40-60% deletion" universality** — qualify as "among published audits" per red team.
- **Audit pattern canonization** — the chapter currently canonizes the month-three audit. Verify the pattern is mature enough to ship without hedging.
- **Managed Agents commercial disclosure** — Anthropic's engineering post is primary source but Anthropic has commercial interest in users running fewer tokens; acknowledge in chapter.

## Source files (raw)

All under `_raw/`. See `_raw/README.md` for full inventory.

- `x-during development.md` — X sweep (Bird + Grok)
- `substack-during development.md` — Substack
- `hn-reddit-during development.md` — HN + Reddit
- `linkedin-vendors-during development.md` — LinkedIn + vendor blogs
- `github-during development.md` — GitHub API ecosystem sweep
- `perplexity-during development.md` — Perplexity synthesis
- `gemini-during development.md` — Gemini Deep Research report
- Fallbacks: `perplexity-websearch-fallback-during development.md`, `x-websearch-fallback-during development.md`
