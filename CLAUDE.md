# CLAUDE.md — Builder-Leader (public showcase repo)

This file is a Claude Code project bible. It describes how the framework that produced *Builder-Leader: The AI Exoskeleton That Crosses the Gap* is structured. It is here for two audiences:

1. Anyone using the skills in `.claude/skills/` on their own writing project — this file tells you what conventions the skills assume.
2. Anyone curious about how the book was made — this file is the operating manual.

The full project bible used during the book's actual production lives in the author's private working repo. That version contains personal-environment paths, internal stakeholder context, and references to the canonical spine. This public version keeps the framework, drops the personal context.

---

## What this is

A nonfiction book on what knowledge work looks like when a senior leader operates through a persistent, multi-agent harness instead of a chat session.

The book is written through the very framework it describes. The production is the proof. The skills under `.claude/skills/` are the framework. The samples under `_samples/` directories show the framework's outputs.

## Production pipeline

Every chapter went through a strict 9-stage pipeline before reaching `ship-ready` status:

| Stage | What runs | Skill | Artifact |
|---|---|---|---|
| 1 | Three-tier research sweep | `book-platform-sweep` | `research/<chapter>/findings.md` + raw files |
| 2 | First draft against canon + research | `book-draft-chapter` | `chapters/NN-<slug>.md` |
| 3 | Structural and adversarial critique | `book-red-team` (Stage 2 mode) | `review-work/<chapter>/04_red_team.md` |
| 4 | Fact-check assertion registry | `book-fact-check` | `review-work/<chapter>/01_assertion_registry.md` |
| 5 | Multi-persona reader simulation | `book-adversarial-reader` | `review-work/<chapter>/05_adversarial_reader.md` |
| 6 | Mechanical voice polish | `book-voice-polish` | `review-work/<chapter>/06_voice_polish.md` |
| 7 | Second red team (final rigor gate) | `book-red-team` (Stage 6 mode) | `review-work/<chapter>/07_red_team_v2.md` |
| 8 | Close-out (apply blockers, resolve questions) | inline judgment | chapter status advances to `ship-ready` |
| 9 | Ship-time citation verify | manual + Wayback | source-index updates |

After all 11 manuscript artifacts pass Stage 7, `book-export` assembles the PDF and EPUB.

## Naming contract

The skills assume a strict directory layout. Replicating it on your own project keeps the skills working without modification.

```
research/
  source-index.md          ← master citation source list
  claims-to-verify.md      ← rolling queue; drafts append, fact-check drains
  verified-claims.md       ← consolidated after claims verify
  NN-<chapter-slug>/
    findings.md            ← consolidated, chapter-level. Drafting reads this first.
    _raw/
      README.md            ← required. Inventory of files.
      <slug>-YYYY-MM-DD.md
chapters/
  NN-<chapter-slug>.md     ← frontmatter: chapter, title, slug, status, word_count, sources, last_drafted
review-work/
  NN-<chapter-slug>/
    01_assertion_registry.md
    04_red_team.md
    05_adversarial_reader.md
    06_voice_polish.md
    07_red_team_v2.md
canon/
  thesis.md                ← single-paragraph pitch + one-sentence thesis + three-bullet skeleton
  outline.md               ← chapter list with per-chapter synopsis
  audience.md              ← who the book is written for
  book-voice.md            ← book-specific voice extensions on top of author's global voice
  voices-to-track.md       ← six tiers of voices in the topic landscape
  book-craft-notes.md      ← craft and structural decisions
planning/
  next-session-agenda.md   ← first moves for the next session
  sessions/
    session-YYYY-MM-DD-<slug>.md
```

Filenames in `_raw/` use platform-first or topic-first slugs with a date suffix: `hn-<topic>-YYYY-MM-DD.md`, `perplexity-<topic>-YYYY-MM-DD.md`, `agi-skeptics-YYYY-MM-DD.md`.

## Hard rule: research before drafting

No chapter gets drafted without its own completed three-tier research sweep. Floor: at least six raw research files per chapter. The `book-platform-sweep` skill enforces this floor and creates the directory structure on first run.

## Voice canon

Every skill that touches prose reads the author's voice canon at session start:

- A global voice file (banned words/phrases, register ladder, structural anti-patterns, authenticity rules).
- A book-specific voice file (`canon/book-voice.md`) that extends the global with book-specific overrides (e.g., the rotation whitelist for "harness" as a synonym for "exoskeleton").

The voice canon is reserved (not in this public repo). The skills' SKILL.md files describe what they look for; you'd substitute your own voice canon to use them.

## Hard rules carried over from the author's global config

Useful even outside this project:

- No em-dashes. Use commas, periods, parentheses.
- Drafted prose runs through a post-draft scan for banned words, em-dashes, and structural anti-patterns.
- Bash scripts use `#!/usr/bin/env bash` (not `/bin/bash`, which is 3.2 on macOS and missing `mapfile`/associative arrays).
- Python uses `uv` for venvs, not `pip --break-system-packages`.

## Session protocol (when a session opens)

1. Read this file.
2. Read `README.md` for the showcase narrative.
3. Read `PRODUCTION-STATS.md` for the numbers.
4. If you're working with the skills on your own writing, look at the `_samples/` directories to see what the artifacts look like in production.

## Skill model rules

The book's skills are voice-sensitive and judgment-heavy. Each skill's frontmatter pins `model: opus` (or `model: sonnet` for the export skill, which is mechanical). Subagent forks were not used for any drafting / red-team / fact-check / voice-polish work because the 8K subagent output cap silently truncates artifacts that are close to or over that ceiling. All judgment work runs inline on main-context Opus.

## Series reuse

The skills are designed to work across multiple books. To reuse them on a sequel or a different book project:

1. Clone the directory layout above into a new project root.
2. Copy `.claude/skills/book-*` into the new project's `.claude/skills/`.
3. Author your own canon files (the SKILL.md files describe what each canon file is for).
4. Run `book-platform-sweep` for chapter 1 to bootstrap research.
5. Run `book-draft-chapter` to produce the first draft.
6. Run the rest of the rigor pipeline per chapter.
7. Run `book-export` when all chapters reach `ship-ready`.

The skills assume the directory layout but make no assumptions about the book's content.
