# Skills used to build *Builder-Leader*

These are the project-local Claude Code skills that produced the manuscript. Each skill encapsulates one stage of the rigor pipeline described in `../../CLAUDE.md`.

## Inventory

| Skill | Stage | What it does | Public state |
|---|---|---|---|
| `book-platform-sweep` | 1 — Research | Three-tier platform sweep (Perplexity, HN, Reddit, Grok, Gemini grounded, Substack pool) → consolidated findings.md | **Full** — all 13 helper scripts ship |
| `book-draft-chapter` | 2 — Draft | Generates a chapter draft against canon + findings, with post-draft scan | **Full SKILL.md** — no helper scripts needed |
| `book-red-team` | 3 (Stage 2 mode) and 7 (Stage 6 mode) — Critique | Structural and adversarial critique. Stage 2 reviews early drafts; Stage 6 is the final rigor gate before export | **Full SKILL.md** — judgment-only, no scripts |
| `book-fact-check` | 4 — Verify | Extracts every factual claim, matches to research, classifies SOURCED / PARTIAL / UNSOURCED / DRIFT | **Full SKILL.md** — judgment-only, no scripts |
| `book-adversarial-reader` | 5 — Reader simulation | Multi-persona reader pass (in-position leader, aspiring leader, hostile reviewer, etc.) | **Full SKILL.md** — judgment-only, no scripts |
| `book-voice-polish` | 6 — Mechanical voice gate | Em-dashes, banned words, sentence-length monotony, paragraph rhythm, heavy-use word frequency | **Full SKILL.md + redacted scan.sh** — banned-word lexicon redacted; scan architecture intact, populate `BANNED_PATTERNS` and `STRUCT_PATTERNS` arrays with your own |
| `book-export` | 9 — Export | Pandoc + xelatex assembly to PDF + EPUB. Refuses ship build if any chapter is not `ship-ready`. Templates included | **Full** — all helpers + LaTeX templates ship |

## What's not here

- **`book-audio-preview`** — replaced by a self-hosted audiobook pipeline (Higgs Audio v2.5 on local GPU). The original Gemini-TTS-based skill is deprecated.
- **The author's voice canon** — the banned-word and structural-anti-pattern lists in `book-voice-polish` are derived from the author's personal voice canon. Replace with your own.

## How to use these on your own writing

1. Copy the skill directory you want into your project's `.claude/skills/`.
2. Open Claude Code from your project root — skills are auto-discovered.
3. The directory layout the skills assume is documented in `../../CLAUDE.md`. Replicate it before invoking.
4. For `book-voice-polish`, populate `scripts/scan.sh` arrays with your own banned-word and structural-pattern lists (from your own voice canon).
5. For all skills: chapter-specific examples in SKILL.md files reference *Builder-Leader* canon — substitute your own canon files and chapter slugs.

## Why these were built project-local, not global

Each skill reads canon, findings, and chapter drafts from a specific directory layout. Shipping them as global skills would require runtime book-root discovery, which adds fragility for one-time use. Project-local skills ship with the book and travel as a unit if you fork the framework for your own writing.

## Model and orchestration rules

All seven skills run inline on main-context Opus (not subagent forks). Subagent 8K output cap silently truncates artifacts close to or over that ceiling — every skill in this set produces output that can hit the cap. SKILL.md frontmatter pins `model: opus` (or `model: sonnet` for `book-export`, which is mechanical).

The skills are designed to be sequential within a chapter (Stage 2 → 3 → 4 → 5 → 6 → 7) and across chapters (one chapter's full pipeline before the next chapter's). Parallel dispatch is explicitly forbidden and the SKILL.md files spell this out.

## Failure modes captured during this book's production

The two SKILL.md "Failure modes to avoid" sections worth specific attention:

- **`book-fact-check`** — DRIFT findings (chapter wording drifts from source) must be revised between fact-check and adversarial-reader. They are NOT voice-polish-deferrable. Voice polish is a clause-and-sentence-level pass for banned words and rhythm — it does not check paraphrase fidelity.
- **`book-voice-polish`** — prose changes from same-day holistic sweeps need a manual voice scan during voice polish. The mechanical scanner sees the post-sweep state as canon and doesn't flag a meta-voice sentence as new just because the sweep wrote it.

Both lessons came from real Stage 6 blockers caught at the final rigor gate. They are now captured in the SKILL.md files for any future book using the same pipeline.
