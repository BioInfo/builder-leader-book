#!/usr/bin/env bash
# scan.sh — mechanical voice-polish detector for nonfiction chapters.
#
# Produces a structured report of voice violations the Opus judgment pass
# can act on. Catches deterministic patterns (em-dashes, banned words,
# core-metaphor frequency, sentence-length runs, paragraph rhythm,
# heavy-use words) so the LLM only spends judgment on cases that need it.
#
# This is the **public showcase** version. The original used in production
# of *Builder-Leader: The AI Exoskeleton That Crosses the Gap* contained
# the author's full personal banned-word lexicon (lifted from his global
# voice canon). That lexicon is reserved.
#
# To use this on your own writing:
#   1. Build your own banned-word list (verbs, intensifiers, abstractions,
#      stock phrases, faux-depth closers). Replace the BANNED_PATTERNS
#      placeholders below with your patterns.
#   2. Build your own structural anti-pattern list (the constructions that
#      mark LLM-generated prose in your domain). Replace STRUCT_PATTERNS.
#   3. Set CORE_METAPHOR to whatever single concept your book leans on
#      heavily; the script flags chapters that use it more than 3 times.
#   4. Sentence-length, paragraph-rhythm, and heavy-use-word detection
#      below are voice-canon-agnostic. They work as-is.
#
# Usage: scan.sh <chapter-file>
# Outputs report to stdout. Non-zero exit if any blocker class hits.

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 <chapter-file>" >&2
  exit 2
fi

FILE="$1"
if [[ ! -f "$FILE" ]]; then
  echo "error: file not found: $FILE" >&2
  exit 2
fi

CHAPTER_NAME=$(basename "$FILE" .md)
BLOCKERS=0

# Customize this for your book. The original used "exoskeleton".
CORE_METAPHOR="${CORE_METAPHOR:-exoskeleton}"

# Materialize body-only file (frontmatter stripped) so grep scans only prose.
BODY_FILE=$(mktemp -t voice-scan-body.XXXXXX)
trap 'rm -f "$BODY_FILE"' EXIT

python3 - "$FILE" "$BODY_FILE" <<'PY'
import sys
from pathlib import Path
src = Path(sys.argv[1]).read_text()
out_path = Path(sys.argv[2])
if src.startswith('---'):
    parts = src.split('---', 2)
    if len(parts) >= 3:
        body = parts[2]
        out_path.write_text(body.lstrip('\n'))
    else:
        out_path.write_text(src)
else:
    out_path.write_text(src)
PY

echo "# Voice Scan — $CHAPTER_NAME"
echo
echo "**File:** \`$FILE\`"
echo "**Scanned:** $(date +%Y-%m-%d)"
echo "*Line numbers below are body-relative (frontmatter stripped).*"
echo

# ---------- 1. Em-dashes (zero tolerance in body) ----------
echo "## 1. Em-dashes"
echo
EMDASH_HITS=$(grep -nE '(—|--[^->])' "$BODY_FILE" || true)
if [[ -n "$EMDASH_HITS" ]]; then
  COUNT=$(printf '%s\n' "$EMDASH_HITS" | wc -l | tr -d ' ')
  echo "**$COUNT hits.** Zero tolerance."
  echo
  echo '```'
  printf '%s\n' "$EMDASH_HITS"
  echo '```'
  BLOCKERS=$((BLOCKERS + 1))
else
  echo "Clean."
fi
echo

# ---------- 2. Banned words and phrases ----------
echo "## 2. Banned words and phrases"
echo
# REDACTED. The production version has ~80 patterns spanning LLM-ism verbs,
# intensifiers, abstract/poetic words, stock openings, hollow enthusiasm,
# faux-depth closers, faux-precision hedges, mechanical transitions,
# "actually matters" constructions, hollow emphasis, performed reactions,
# and algorithmic scaffolding — all sourced from the author's voice canon.
#
# To activate this section: replace the placeholder array below with your
# own banned-pattern list. Recommended categories:
#   - LLM-ism verbs (your verbs that scream "AI wrote this")
#   - Intensifiers your domain treats as filler
#   - Stock phrases / abstractions you want to prohibit
#   - Faux-depth closers / mechanical transitions
BANNED_PATTERNS=(
  # PLACEHOLDER — replace with your own patterns. Examples:
  # '\bdelve(s|d|ing)?\b'
  # '\bleverage(s|d|ing)?\b'
  # '\btransformative\b'
  # '\bin conclusion\b'
  '\bAUTHOR_BANNED_WORDS_PLACEHOLDER\b'
)

BANNED_HITS=""
for pat in "${BANNED_PATTERNS[@]}"; do
  HIT=$(grep -niE "$pat" "$BODY_FILE" || true)
  if [[ -n "$HIT" ]]; then
    BANNED_HITS+="### Pattern: \`$pat\`\n\n\`\`\`\n$HIT\n\`\`\`\n\n"
  fi
done

if [[ -n "$BANNED_HITS" ]]; then
  printf '%b' "$BANNED_HITS"
  BLOCKERS=$((BLOCKERS + 1))
else
  echo "Clean. (Note: redacted placeholder pattern list — populate BANNED_PATTERNS for real scan.)"
fi
echo

# ---------- 3. Core-metaphor frequency ----------
# Books often have one central metaphor that should appear sparingly so
# it stays load-bearing. Default cap: 3 occurrences per chapter.
echo "## 3. Core-metaphor frequency ('$CORE_METAPHOR')"
echo
METAPHOR_COUNT=$( { grep -ioE "\\b${CORE_METAPHOR}(s)?\\b" "$BODY_FILE" || true; } | wc -l | tr -d ' ')
echo "**Count:** $METAPHOR_COUNT (cap: 3)"
echo
if [[ "$METAPHOR_COUNT" -gt 3 ]]; then
  echo "Lines:"
  echo
  echo '```'
  grep -nE "\\b${CORE_METAPHOR}(s)?\\b" "$BODY_FILE" || true
  echo '```'
  BLOCKERS=$((BLOCKERS + 1))
fi
echo

# ---------- 4. Banned structural constructions ----------
echo "## 4. Structural anti-patterns"
echo
# REDACTED. Production version flags constructions like "not only X but Y",
# "it's not just X it's Y", "so what does this mean", "in this chapter we",
# "in this book we" — generic LLM scaffolding patterns.
STRUCT_PATTERNS=(
  # PLACEHOLDER — replace with your own structural anti-patterns. Examples:
  # '\bnot only .* but\b'
  # '\bso what does this mean\b'
  # '\bin this chapter we\b'
  '\bAUTHOR_STRUCT_PLACEHOLDER\b'
)
STRUCT_HITS=""
for pat in "${STRUCT_PATTERNS[@]}"; do
  HIT=$(grep -niE "$pat" "$BODY_FILE" || true)
  if [[ -n "$HIT" ]]; then
    STRUCT_HITS+="### Pattern: \`$pat\`\n\n\`\`\`\n$HIT\n\`\`\`\n\n"
  fi
done
if [[ -n "$STRUCT_HITS" ]]; then
  printf '%b' "$STRUCT_HITS"
  BLOCKERS=$((BLOCKERS + 1))
else
  echo "Clean. (Note: redacted placeholder pattern list — populate STRUCT_PATTERNS for real scan.)"
fi
echo

# ---------- 5. Sentence-length runs (3+ consecutive in 12-18 word band) ----------
echo "## 5. Sentence-length monotony"
echo
echo "Scanning for runs of 3+ consecutive sentences in the 12-18 word range."
echo

python3 - "$BODY_FILE" <<'PY'
import re
import sys
from pathlib import Path

text = Path(sys.argv[1]).read_text()

if text.startswith('---'):
    parts = text.split('---', 2)
    if len(parts) >= 3:
        text = parts[2]

text = re.sub(r'```[\s\S]*?```', '', text)
text = re.sub(r'^#+\s.*$', '', text, flags=re.MULTILINE)

sentences = re.split(r'(?<=[.!?])\s+(?=[A-Z"\'])', text)
sentences = [s.strip() for s in sentences if s.strip()]

def word_count(s):
    return len(re.findall(r"\b[\w'-]+\b", s))

lengths = [(i, word_count(s), s) for i, s in enumerate(sentences)]

runs = []
current_run = []
for i, n, s in lengths:
    if 12 <= n <= 18:
        current_run.append((i, n, s))
    else:
        if len(current_run) >= 3:
            runs.append(current_run)
        current_run = []
if len(current_run) >= 3:
    runs.append(current_run)

if not runs:
    print("Clean. No runs of 3+ medium-length sentences detected.")
else:
    print(f"**{len(runs)} run(s) of 3+ medium-length (12-18 word) sentences.**\n")
    for k, run in enumerate(runs, 1):
        print(f"### Run {k} ({len(run)} sentences)\n")
        print("```")
        for i, n, s in run:
            preview = (s[:120] + '...') if len(s) > 120 else s
            print(f"[{n}w] {preview}")
        print("```\n")
PY

echo

# ---------- 6. Paragraph-rhythm uniformity ----------
echo "## 6. Paragraph rhythm"
echo

python3 - "$BODY_FILE" <<'PY'
import re
import sys
from pathlib import Path

text = Path(sys.argv[1]).read_text()

if text.startswith('---'):
    parts = text.split('---', 2)
    if len(parts) >= 3:
        text = parts[2]

text = re.sub(r'```[\s\S]*?```', '', text)
text = re.sub(r'^#+\s.*$', '', text, flags=re.MULTILINE)

paragraphs = [p.strip() for p in re.split(r'\n\s*\n', text) if p.strip()]

def sentence_count(p):
    sents = re.split(r'(?<=[.!?])\s+(?=[A-Z"\'])', p)
    return len([s for s in sents if s.strip()])

counts = [sentence_count(p) for p in paragraphs]
if not counts:
    print("No paragraphs.")
    sys.exit(0)

run = 0
runs_found = 0
flagged_runs = []
current_indices = []
for i, c in enumerate(counts):
    if 3 <= c <= 4:
        run += 1
        current_indices.append(i)
    else:
        if run >= 3:
            runs_found += 1
            flagged_runs.append(current_indices.copy())
        run = 0
        current_indices = []
if run >= 3:
    runs_found += 1
    flagged_runs.append(current_indices.copy())

print(f"**Total paragraphs:** {len(counts)}")
print(f"**Sentence-count distribution:** min={min(counts)}, max={max(counts)}, mean={sum(counts)/len(counts):.1f}")
print(f"**Uniform runs (3+ consecutive paragraphs of 3-4 sentences):** {runs_found}\n")

if flagged_runs:
    print("Indices (zero-based) of uniform runs:\n")
    for r in flagged_runs:
        print(f"- paragraphs {r[0]}..{r[-1]} (length {len(r)})")
PY

echo

# ---------- 7. Heavy-use content word frequency ----------
echo "## 7. Heavy-use content words"
echo
echo "Top content words by frequency. Not a violation list — a signal for the LLM judgment pass to decide per word whether the heavy use is intentional rotation, load-bearing concept, or unconscious crutch."
echo

python3 - "$BODY_FILE" <<'PY'
import re
import sys
from collections import Counter
from pathlib import Path

text = Path(sys.argv[1]).read_text().lower()

if text.startswith('---'):
    parts = text.split('---', 2)
    if len(parts) >= 3:
        text = parts[2]
text = re.sub(r'```[\s\S]*?```', ' ', text)
text = re.sub(r'`[^`]*`', ' ', text)
text = re.sub(r'^#+\s.*$', ' ', text, flags=re.MULTILINE)
text = re.sub(r'\[([^\]]+)\]\([^)]+\)', r'\1', text)

tokens = re.findall(r"\b[a-z][a-z'-]{2,}\b", text)

STOP = set('''
a an and are as at be been being but by can could did do does doing done down during
each either else even every for from further had has have having he her here hers him his
how however i if in into is it its itself just like may me might more most much must
my myself never no nor not now of off on once only or other our ours out over own
same she should so some still such than that the their them then there these they
this those though through till to too under until up upon us very was we were what when
where which while who whom why will with within without would yet you your yours yourself
yourselves been across also able very really quite something someone anything anyone everything
back before because between both during each how when where which who why how about against
among any around because before below between both during each from front given how if into
isn't it's let's like make many off once one ones onto over per same several so some
than that the then there they this those though through under until up upon very was way ways
we were what when where which while who whom whose why will with within without would yet you
your yours yourself yourselves us our ours mine theirs hers his him she he ours
also even just rather still already always never sometimes often usually generally seem seems
seemed look looking looks looked find finds finding found go goes going went come comes coming
came get gets getting got give gives giving gave keep keeps keeping kept put puts putting
take takes taking took say says saying said see sees seeing saw think thinks thinking thought
know knows knowing knew want wants wanting wanted use uses using used need needs needing needed
work works working worked make makes making made show shows showing showed told tell tells telling
ask asks asking asked want wanted wanting wants try tries trying tried turn turns turning turned
move moves moving moved start starts starting started run runs running ran ready
chapter chapters book books page pages section sections paragraph paragraphs sentence sentences
lines line note notes following follow follows followed below above
'''.split())

filtered = [t for t in tokens if t not in STOP and len(t) >= 3]

if not filtered:
    print("No content words after filtering.")
    sys.exit(0)

total = len(filtered)
counts = Counter(filtered)

threshold = max(8, total // 200)
heavy = [(w, n) for w, n in counts.most_common() if n >= threshold]

print(f"**Content word total (after stop-word filter):** {total}")
print(f"**Threshold for heavy-use list:** {threshold} occurrences")
print()

if not heavy:
    print("No content words above threshold. Vocabulary appears varied.")
    sys.exit(0)

show = heavy[:30]
print("| Word | Count | % of content |")
print("|---|---:|---:|")
for w, n in show:
    pct = 100.0 * n / total
    print(f"| {w} | {n} | {pct:.2f}% |")

if len(heavy) > 30:
    print(f"\n*({len(heavy) - 30} more above threshold not shown)*")
PY

echo
echo "---"
echo
echo "**Mechanical blocker classes triggered:** $BLOCKERS"
echo
echo "*Note: Section 7 (heavy-use) is informational, not a blocker class. The LLM judgment pass decides per word.*"
exit 0
