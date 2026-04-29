---
name: book-platform-sweep
description: Full three-tier research sweep for one chapter of The AI Exoskeleton book. Tier 1 raw platform sweep (Perplexity / HN with comment bodies / Reddit with post bodies / Grok x_search / Gemini grounded / shared Substack pool). Tier 2 open-ended discovery sweep ("surprise me") + firecrawl URL body extraction + per-URL sub-summaries. Tier 3 hybrid two-pass synthesis: Pass A (Sonnet, mechanical rollup) + Pass B (Opus, judgment synthesis) → raw-summary + discovery-summary + 1000+-line merged findings.md. Run before drafting any chapter. Floor: six Tier-1 files + three Tier-2 files + ≥15 URL bodies.
model: opus
---

# book-platform-sweep

The authoritative research pipeline for every chapter of the book. No chapter gets drafted without a completed sweep through all three tiers. See `CLAUDE.md` → "Hard rule: research before drafting, every chapter, every time" for the enforcement language.

Built. Rewritten after Justin asked for open-ended discovery, fetched-URL content extraction, Sonnet/Opus synthesis over Gemini, and a consistent pipeline across all chapters.

## Inputs

- **Chapter slug** — e.g. `01-two-groups`, `05-the-components`. Required.
- **Mode** (optional) — `tier1`, `tier2`, `tier3`, or `full`. Default `full`.

## What the three tiers produce

```
research/NN-<slug>/
├── _raw/                                 ← Tier 1
│   ├── perplexity-<date>.md              (Sonar Pro, targeted queries from canon/outline + findings)
│   ├── hn-<date>.md                      (Algolia link ranking, 6 topic queries, 90-day window)
│   ├── hn-content-<date>.md              (top 12 stories with selftext + top-6 comment BODIES)
│   ├── reddit-<date>.md                  (4 chapter-relevant subs, top/month link list)
│   ├── reddit-content-<date>.md          (top 12 posts with selftext + top-6 comment BODIES)
│   ├── x-grok-<date>.md                  (Grok x_search on engagement, 60-day window)
│   ├── gemini-<date>.md                  (Gemini 3 Flash Preview with Google Search grounding)
│   └── raw-summary-<date>.md             ← Tier 3 Pass A output (Sonnet subagent)
│
├── _raw-discovery/                       ← Tier 2
│   ├── perplexity-discovery-<date>.md    ("surprise me, don't confirm thesis")
│   ├── gemini-discovery-<date>.md        (same prompt, Gemini 3 Flash Preview)
│   ├── x-grok-discovery-<date>.md        (same prompt, Grok x_search)
│   ├── fetched/                          ← Firecrawl DGX body extraction
│   │   └── <hash>.md                     (one file per cited URL, cleaned markdown)
│   ├── url-summaries/                    ← Per-URL sub-summaries (Gemini 3 Flash bulk)
│   │   └── <hash>.md                     (Source identity / Central claim / Key quotes / Named anchors / Stance / Usefulness tags / Caveats)
│   ├── discovery-bodies-<date>.md        (consolidated excerpts, one per URL)
│   └── discovery-summary-<date>.md       ← Tier 3 Pass A output (Sonnet subagent)
│
└── findings.md                           ← Tier 3 Pass B output (main-context Opus, INLINE — 1000+ lines, merged+deduped)
```

Plus the cross-chapter pool:

```
research/_shared/_raw/
└── substack-pool-<date>.md               (Mollick / Marcus / Mitchell / Chollet archives + bodies via Substack /api/v1/)
```

## The helpers

All scripts live in `.claude/skills/book-platform-sweep/scripts/` and are idempotent (safe to rerun; skip already-written outputs).

| Script | Tier | Role |
|---|---|---|
| `perplexity-sweep.sh <slug> <query>` | 1 | Perplexity Sonar Pro with chapter-specific query |
| `hn-sweep.sh <slug> <topic>...` | 1 | HN Algolia link ranking (6 topics) |
| `hn-content.sh <slug>` | 1 | HN Algolia /items/ — story selftext + top comment bodies |
| `reddit-sweep.sh <slug> <sub>...` | 1 | Reddit JSON top/month (4 subs) |
| `reddit-content.sh <slug>` | 1 | Reddit JSON per-post — selftext + top comment bodies |
| `grok-sweep.sh <slug> <query>` | 1 | xAI Grok `x_search` for engagement discovery |
| `gemini-sweep.sh <slug> <query>` | 1 | Gemini 3 Flash Preview with `google_search` grounding |
| `substack-pool.sh` | 1 shared | Direct Substack `/api/v1/archive` + `/posts/by-id/` — all named voices |
| `discovery-sweep.sh <slug> <prompt>` | 2 | Open-ended "surprise me" Perplexity + Gemini + Grok in one shot |
| `fetch-discovery-urls.sh <slug>` | 2 | Firecrawl on DGX (http://100.101.43.40:3333) — one fetch per unique cited URL |
| `url-summarize.sh <slug>` | 2 | Gemini 3 Flash Preview — 150-word summary per fetched URL body |
| `synth-chapter.sh <slug>` | 3 quick-pass | Single Gemini 3 Flash Preview pass over all discovery bodies (legacy / spot-check only) |

The real Tier 3 work is done via `Agent(subagent_type="research-synthesizer", ...)` — see the prompt templates below. **Pass A uses Sonnet 4.6 (mechanical rollup); Pass B uses Opus 4.7 (judgment-heavy synthesis).** The hybrid split was calibrated during development against the Opus quota — Pass A's "read files, extract verbatim quotes, organize by source" doesn't earn the Opus premium, but Pass B's dedup + structural framing does. Do NOT use `synth-chapter.sh` as the authoritative synthesis. Gemini is for bulk commodity summarization only.

## Model choices (locked)

- **Perplexity:** `sonar-pro` for targeted queries, same for domain-filtered Substack pool.
- **Gemini:** `gemini-3-flash-preview`. NEVER `gemini-2.0-flash`, NEVER `gemini-3.1-flash-lite-preview`, and NEVER any other variant without consulting Justin first.
- **xAI:** `grok-4-latest` via `https://api.x.ai/v1/responses` with `x_search` tool.
- **Tier 3 Pass A (mechanical rollup):** Sonnet 4.6 subagent (`research-synthesizer`, `model: sonnet`). Reading + extracting verbatim quotes + organizing by source = Sonnet handles fine, ~2x faster, ~5x cheaper than Opus.
- **Tier 3 Pass B (judgment synthesis):** **Main-context Opus 4.7, INLINE.** Subagent output cap is 8K regardless of model; findings.md targets 1000+ lines = 6-10K. Subagent Pass B truncates. Main context has 32K cap. Dedup across noisy sources, structural calls about what's a finding vs noise, counter-thesis framing — opus territory. Never Sonnet, never Gemini, never as a subagent.

Gemini 3 Flash Preview is adequate for bulk per-URL summarization (220 URLs × ~30s each). The hybrid Sonnet/Opus split for synthesis was calibrated during development — Pass A's mechanical extraction doesn't earn the Opus premium, Pass B's dedup + structural framing does.

## Recency anchoring (mandatory, baked into wrapped scripts)

All book scripts in `scripts/` are now thin wrappers over `~/apps/claude-code/skills/topic-platform-sweep/scripts/`, which automatically wrap Gemini and discovery prompts with explicit "today is YYYY-MM-DD, reject anything before SINCE" anchoring.

**Why this exists:** Gemini's `google_search` grounding silently drifts to 2024 results when prompts only say "last 60 days." Discovered when the open-weights Sunday Deep Dive sweep returned Sept-Oct 2024 sources from a "last 60 days" prompt. The anchored prompt forces the model to either return in-window items or explicitly say it can't.

**Audit after every Gemini sweep** — grep dates and verify the window:

```bash
grep -oE '20[0-9]{2}-[0-9]{2}-[0-9]{2}|Sep 2024|Oct 2024' research/<chapter>/_raw/gemini-*.md | sort | uniq -c
grep -oE '20[0-9]{2}-[0-9]{2}-[0-9]{2}|Sep 2024|Oct 2024' research/<chapter>/_raw-discovery/gemini-discovery-*.md | sort | uniq -c
```

If pre-floor dates appear, rename to `<platform>-discovery-stale-<DATE>.md` and re-run via the wrapped script.

## Prerequisites

All keys in `pass`:

```bash
pass api-keys/perplexity
pass api-keys/xai
# Gemini: macOS Keychain `gemini-api-key` (NOT pass)
security find-generic-password -s 'gemini-api-key' -w
```

Firecrawl must be up on DGX:

```bash
curl -s -o /dev/null -w "%{http_code}\n" -X POST http://100.101.43.40:3333/v1/scrape \
  -H 'Content-Type: application/json' \
  -d '{"url":"https://example.com","formats":["markdown"]}'
# Expected: 200
```

If firecrawl is down, Justin usually starts it manually via the DGX Docker stack. Ask him rather than guessing at the right systemd / docker-compose command.

## Procedure

### 0. Load chapter context

```
canon/thesis.md                    — current book thesis
canon/outline.md                   — chapter role + sourcing table
canon/book-voice.md                — voice rules
canon/voices-to-track.md           — named voices per chapter
canon/research-rules.md            — recency window (preferred 3mo, default 6mo)
research/NN-<slug>/findings.md     — existing research questions (A-E)
```

### 1. Tier 1 — raw platform sweep

Dispatch all six platform scripts in parallel. Each chapter targets different topic phrasings pulled from its research questions:

```bash
SLUG=02-what-you-see

./scripts/perplexity-sweep.sh "$SLUG" "State of Karpathy autoresearch, Mollick three-tier taxonomy adoption, Group 3 inside Group 2 discourse. Primary sources, URLs, dates." &

./scripts/hn-sweep.sh "$SLUG" "Karpathy autoresearch" "agent harness" "Claude Code skills" "Mollick three tier" "MCP server" "AI exoskeleton" &

./scripts/hn-content.sh "$SLUG" &   # depends on hn-sweep.sh output; run AFTER that completes

./scripts/reddit-sweep.sh "$SLUG" "ClaudeAI" "ChatGPTPro" "singularity" "LocalLLaMA" &

./scripts/reddit-content.sh "$SLUG" &   # same dependency

./scripts/grok-sweep.sh "$SLUG" "Highest-engagement X posts last 60 days on Karpathy autoresearch, agent harness, Group 3 framing. @handle, verbatim text, URL, likes." &

./scripts/gemini-sweep.sh "$SLUG" "Summarize state of AI harness/operator discourse April 2026. Karpathy autoresearch, Mollick three-tier, exoskeleton metaphor. Primary sources, URLs, dates." &

wait
```

Run `./scripts/substack-pool.sh` once for the whole book, not per chapter. Output lands in `research/_shared/_raw/substack-pool-<date>.md`.

### 2. Tier 2 — open-ended discovery

One discovery-sweep.sh dispatch per chapter. The prompt is deliberately contrarian ("surprise me, don't confirm my thesis"):

```bash
./scripts/discovery-sweep.sh "$SLUG" "I am writing a book chapter that argues X. Before I finalize this framing, surprise me. What is actually happening in the last 60 days that my framing might miss, simplify, or get wrong? What alternative frames are serious people using? What surprising ideas, data, incidents, or reframings might complicate, contradict, or improve my thesis? Do not try to confirm it. Give 10-15 specific items with URLs and dates."
```

This writes three files to `_raw-discovery/`: Perplexity, Gemini, Grok outputs.

Then fetch every cited URL via firecrawl:

```bash
./scripts/fetch-discovery-urls.sh "$SLUG"
```

Each unique URL lands as `_raw-discovery/fetched/<hash>.md` (SHA-1 first 12 chars as filename). A consolidated `discovery-bodies-<date>.md` excerpts the first 40 lines of each.

Then per-URL sub-summaries:

```bash
./scripts/url-summarize.sh "$SLUG"
```

Each URL body → one structured summary at `_raw-discovery/url-summaries/<hash>.md`. The summarizer automatically flags:
- Bodies under 500 bytes (likely blocked or hallucinated URL)
- "Access Denied" / "Just a moment" / Cloudflare challenge pages
- Bot-blocked McKinsey, Morningstar (common)

### 3. Tier 3 — HYBRID synthesis: Pass A via subagent, Pass B INLINE in main context

**Critical constraints learned across development sessions:**

1. A single subagent asked to write three files (raw-summary + discovery-summary + 1000+-line findings.md) plus return a report hits the 8K output token cap before finishing. Across the first 10-chapter dispatch, 9 of 10 subagents wrote the two summaries then died before finishing findings.md, and 1 of 10 failed to write anything.

2. **(Confirmed across 7 parallel retry subagents)** When the Claude Code session runs with ToolSearch-deferred-tools mode active, subagents behave unpredictably on Pass B findings.md generation:
   - 3 of 7 hit the 8K output token cap with ZERO text returned (Ch 3, 6, 9) — complete loss.
   - 1 of 7 stalled with "no progress for 600s" (Ch 10) — complete loss.
   - 1 of 7 silently hallucinated Write tool calls — claimed ~260 lines of synthesis, file mtime unchanged (Ch 5).
   - 1 of 7 was honest about the Write block and returned partial synthesis as text (Ch 2).
   - 1 of 7 returned a full synthesis as task-notification text, also without landing a file (Ch 1 retry).

   Net: **zero subagents successfully wrote findings.md to disk across the 7-chapter retry.** The prior-session Ch 4 (1,018 lines) is the only confirmed subagent-written findings.md in the the production arc and came from a non-ToolSearch session.

**The fix: hybrid synthesis.**

- **Pass A (summaries):** Sonnet subagent via `research-synthesizer`. Writes two short files (~200 lines each). Short writes survive both failure modes empirically.
- **Pass B (findings.md):** **DO NOT dispatch to a subagent.** Run INLINE in the main Claude Code Opus context. The main context has no 8K output cap and is not subject to ToolSearch Write deferral. Write the file via one Write call + one or two Edit appends. This is the only reliable way to land a 500-900 line findings.md in development sessions.

**Verification rule.** A subagent task-notification with status `completed` and a plausible-looking synthesis in its `<result>` block is NOT evidence that a file was written. Always `wc -l` or `stat` the target file after a subagent "completes" a Write task, and compare mtime against session start. Trust the filesystem, not the report.

**Salvage pattern.** If subagents have already been dispatched for Pass B and returned full synthesis text in their task-notification `<result>` instead of writing to disk, that text can be extracted and written to `findings.md` inline in main context. Ch 1 retry (during development later session) was salvaged this way: subagent returned ~48 citation keys and structured A-E synthesis as text, main-context Opus copied the text into `research/01-two-groups/findings.md` via Write. Output quality is equivalent to a clean subagent write. If the subagent returned no text (8K cap hit or stall), there is nothing to salvage — draft that chapter's findings.md inline from raw files.

#### Pass A — summaries (one Sonnet 4.6 subagent per chapter)

```
Agent(
  subagent_type="research-synthesizer",
  model="sonnet",
  prompt=<Pass A template>
)
```

Pass A prompt template:

> You are producing TWO summary files for Chapter N of the book. Chapter slug: `NN-<slug>`. Chapter role: [pull from outline].
>
> **Inputs** (read from disk, no web):
> - `canon/thesis.md`, `canon/outline.md`, `canon/book-voice.md`, `canon/voices-to-track.md`
> - `chapters/NN-<slug>.md` if drafted
> - `research/NN-<slug>/findings.md` (current — DO NOT REPLACE; Pass B will handle findings.md)
> - `research/NN-<slug>/_raw/*.md`
> - `research/NN-<slug>/_raw-discovery/*.md`
> - `research/NN-<slug>/_raw-discovery/fetched/*.md` — 15-35 fetched URL bodies
> - `research/NN-<slug>/_raw-discovery/url-summaries/*.md`
> - `research/_shared/_raw/substack-pool-<date>.md`
> - `research/source-index.md`, `research/claims-to-verify.md`, `research/verified-claims.md`
>
> **Outputs** (exactly two files, in order):
> 1. `research/NN-<slug>/_raw/raw-summary-<date>.md` (150-250 lines) — consolidates platform sweep. Every factual anchor with citation key. Per-platform rollup (HN threads, Reddit substance, Grok high-engagement posts with verbatim quotes, Substack recent posts). Named voices. Open questions.
> 2. `research/NN-<slug>/_raw-discovery/discovery-summary-<date>.md` (150-250 lines) — rolls up URL summaries + discovery sweeps. Counter-thesis candidates. Per-source synthesis grouped by theme. Emerging vocabulary. Blocked/hallucinated URLs flagged.
>
> **Discipline:** Never fabricate quotes. Verbatim quotes under 30 words in quotes. No em-dashes. Citation keys `{author-slug}-{topic}-{YYYY-MM-DD}`. Flag blocked/hallucinated URLs explicitly.
>
> **Return report: under 150 words. Just line counts and newly-added citation keys. The files are the output, not the report.**

#### Pass B — merged findings.md (INLINE in main-context Opus 4.7, AFTER Pass A subagent completes)

**Do NOT dispatch as a subagent.** Subagent output cap is 8K regardless of model. findings.md needs 6-10K. Run inline in the main Opus 4.7 context (32K cap).

**Inline procedure** (main agent runs this directly, not via Agent tool):

1. Read Pass A outputs from disk:
   - `research/NN-<slug>/_raw/raw-summary-<date>.md`
   - `research/NN-<slug>/_raw-discovery/discovery-summary-<date>.md`
2. Read existing `research/NN-<slug>/findings.md` to preserve research-question structure (A-E)
3. Read specific url-summaries on demand for verbatim quotes (don't blow context — pull only what you need)
4. Optionally Grep `research/_shared/_raw/substack-pool-<date>.md` for specific named-voice quotes
5. Write `research/NN-<slug>/findings.md` via Write. REPLACE the existing file. Merged, deduped, organized by research question (A-E from existing). Every finding: verbatim anchor quote (<30 words, quoted), source URL, author, date, citation key, one-line "why it matters for this chapter." Merge duplicates: same quote across multiple sweeps = one entry naming all platforms. Counter-thesis + open questions section. Proposed chapter edits section. Tier-6 voice additions. Source file inventory. Target 1000+ lines.
6. If file approaches 1500 lines, write in chunks: first Write creates the file with sections A-C, follow-up Edits append D-E + the closing sections.

**Discipline:** Never fabricate quotes. Pull verbatim from Pass A summaries or url-summaries. No em-dashes. Citation keys standardized.

#### Why this works

Pass A subagent: two files at ~200 lines each + a 150-word report = ~3K output tokens. Comfortably under the 8K subagent cap.

Pass B inline (main Opus 4.7): one file at 1000+ lines = ~6-10K output tokens. Main-context Opus has a 32K output cap, so this lands cleanly. Subagent Pass B fails because the 8K cap truncates findings.md mid-write — an empirical failure mode observed across multiple book chapters in development testing.

Always include any chapter-specific counter-thesis context from `planning/thesis-pivot-candidates-<date>.md` in both passes.

### 4. Post-synthesis updates

After Pass A (Sonnet subagent) writes the two summaries and Pass B (main-context Opus, inline) writes findings.md, update:

- `canon/voices-to-track.md` Tier 6 — append any new voices flagged in the subagent's report
- `research/source-index.md` — add new citation keys
- `research/claims-to-verify.md` — move open claims from the subagent's "open claims" section

### 5. Naming enforcement

Every file on disk must match the CLAUDE.md naming contract:

- Raw platform files: `<platform>-<YYYY-MM-DD>.md`
- Content-extracted files: `<platform>-content-<YYYY-MM-DD>.md`
- Discovery files: `<platform>-discovery-<YYYY-MM-DD>.md`
- URL bodies: `<sha1-12>.md` inside `_raw-discovery/fetched/`
- URL summaries: `<sha1-12>.md` inside `_raw-discovery/url-summaries/` (same hash as the body)
- Tier-3 outputs: `raw-summary-<YYYY-MM-DD>.md`, `discovery-summary-<YYYY-MM-DD>.md`, `findings.md` (no date; living artifact)
- Same-day reruns: append `-rerun` or `-v2` before the date
- Each subdir with >3 files needs a `README.md` inventory

Run an audit after every full sweep (see "Audit checklist" below).

## Audit checklist (run after every full sweep)

1. All six Tier-1 files exist per chapter, dated today
2. All three Tier-2 discovery files exist per chapter, dated today
3. `fetched/` contains one file per unique URL cited in discovery sweeps (no orphans, no duplicates)
4. `url-summaries/` has matching count; every `<hash>.md` in `fetched/` has a corresponding file in `url-summaries/` (or is flagged `SKIPPED` because under 500 bytes / bot-blocked)
5. Tier-3 files exist: `raw-summary-<date>.md`, `discovery-summary-<date>.md`, `findings.md`
6. `findings.md` is 1000+ lines and organized by research question
7. New voices in subagent report are appended to Tier 6 of `canon/voices-to-track.md`
8. New citation keys appear in `research/source-index.md`
9. No empty scaffolding directories
10. All filenames match the naming contract

## Failure modes to avoid

- **Gemini 2.0 Flash / Flash-Lite** — fixed during development, never revert. Model choice must be explicit and approved.
- **Stale dates from Gemini grounded search.** Without the recency-anchor preamble (now baked into the wrapped topic scripts), Gemini returns Sept-Oct 2024 results. Always audit dates after a Gemini sweep. See "Recency anchoring" section above.
- **Shallow HN / Reddit link lists** — always follow the link-list sweep with the `-content.sh` extraction. The wisdom is in the comments, not the titles.
- **Perplexity with Substack domain filter** — returned "I cannot find specific posts" nonsense. Use `substack-pool.sh` via direct Substack `/api/v1/` instead.
- **Hallucinated URLs** — Gemini and Grok both fabricate X status IDs and placeholder arxiv slugs. The `url-summarize.sh` auto-flags these; the opus subagent must call them out explicitly in the discovery-summary.
- **Forking research synthesis to Sonnet or Gemini** — all three-tier synthesis is opus. Bulk URL summarization is Gemini. Never mix.
- **Subagent output without source files** — subagent must write its outputs to disk and return a report; never let its report BE the output.
- **Running last30days alone** — it samples shallowly across platforms. Full sweep replaces it.
- **Reading subagent output files via Read or Bash tail** — those are JSONL transcripts that overflow context. Read the artifacts the subagent wrote to disk instead.
- **Long queries to HN Algolia** — rejects URLs over ~1000 chars. Keep topic queries short.
- **URL-encoding `>` in HN filters** — must be `%3E`, not raw `>`. The `hn-sweep.sh` handles this; don't copy-paste a raw curl.
- **Reddit without `-L`** — reddit.com → www.reddit.com redirect is a 301. Always `-L`.

## Cost notes

Per full-book pass (10 chapters) roughly:

- Perplexity Sonar Pro: ~40 calls, ~$3
- Gemini 3 Flash Preview: ~250 calls (10 × gemini-sweep + 10 × gemini-discovery + 220 × url-summarize + 10 × synth-chapter spot checks), ~$2
- xAI Grok x_search: ~20 calls, ~$0.10
- HN Algolia + Reddit JSON: free
- Firecrawl DGX: free (self-hosted)
- Hybrid subagent synthesis: 10 Pass A runs on Sonnet (~$2-5 total) + 10 Pass B runs on Opus (~$15-30 total). Pass B is the highest-leverage dollar in the whole pipeline.

Budget ~$15-25 per full-book pass + the opus-subagent cost on top. One pass per 4-6 weeks of manuscript work should be the cadence.

## Session log discipline

Every sweep session should produce `planning/sessions/session-<YYYY-MM-DD>-<slug>.md` describing what was run, what landed, what failed, and what needs re-running. Same rule as every other book session.
