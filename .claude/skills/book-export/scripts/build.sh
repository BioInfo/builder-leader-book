#!/usr/bin/env bash
# build.sh — assemble chapters/ into a typeset PDF (and optionally EPUB).
# Usage:
#   ./build.sh                 # preview mode (default)
#   ./build.sh preview         # preview, DRAFT-watermarked
#   ./build.sh ship            # gated on every chapter status=ship-ready
#   ./build.sh preview epub    # also produce EPUB

set -euo pipefail

# ---------------------------------------------------------------------------
# Locate the project
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
BOOK_ROOT="$(cd "$SKILL_DIR/../../.." && pwd)"
CHAPTERS_DIR="$BOOK_ROOT/chapters"
CANON_DIR="$BOOK_ROOT/canon"
EXPORT_DIR="$BOOK_ROOT/export"
TEMPLATES_DIR="$SKILL_DIR/templates"

[[ -d "$CHAPTERS_DIR" ]] || { echo "ERROR: chapters/ not found at $CHAPTERS_DIR" >&2; exit 1; }
mkdir -p "$EXPORT_DIR"

# ---------------------------------------------------------------------------
# Parse args
# ---------------------------------------------------------------------------
MODE="${1:-preview}"
EXTRA="${2:-}"

case "$MODE" in
  preview|ship) ;;
  *) echo "ERROR: first argument must be 'preview' or 'ship' (got '$MODE')" >&2; exit 1 ;;
esac

WANT_EPUB=0
[[ "$EXTRA" == "epub" ]] && WANT_EPUB=1

# ---------------------------------------------------------------------------
# Check dependencies
# ---------------------------------------------------------------------------
need() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "ERROR: '$1' not on PATH. $2" >&2
    exit 1
  fi
}
need pandoc    "Install with: brew install pandoc"
need xelatex   "Install with: brew install --cask mactex-no-gui  (or basictex)"

# Required LaTeX packages (subset; fontspec/microtype ship with TeX Live)
MISSING_TL=()
for pkg in fontspec.sty microtype.sty geometry.sty fancyhdr.sty xcolor.sty hyperref.sty setspace.sty; do
  kpsewhich "$pkg" >/dev/null 2>&1 || MISSING_TL+=("${pkg%.sty}")
done
if (( ${#MISSING_TL[@]} > 0 )); then
  echo "ERROR: missing LaTeX packages: ${MISSING_TL[*]}" >&2
  echo "Install with: sudo tlmgr install ${MISSING_TL[*]}" >&2
  exit 1
fi

# Iowan Old Style ships with macOS at /System/Library/Fonts/Supplemental/.
# xelatex reads system fonts directly and does not rely on fontconfig, so
# skip the fc-list check (it does not index .ttc collection fonts reliably).

# ---------------------------------------------------------------------------
# Enumerate chapters
# ---------------------------------------------------------------------------
mapfile -t CHAPTER_FILES < <(find "$CHAPTERS_DIR" -maxdepth 1 -type f -name '[0-9][0-9]-*.md' | sort)
if (( ${#CHAPTER_FILES[@]} == 0 )); then
  echo "ERROR: no chapter files found in $CHAPTERS_DIR" >&2
  exit 1
fi
echo "Found ${#CHAPTER_FILES[@]} chapter files."

# ---------------------------------------------------------------------------
# Read frontmatter helper
# ---------------------------------------------------------------------------
# Usage: fm_get <file> <key>
fm_get() {
  awk -v key="$2" '
    BEGIN { fm=0 }
    /^---$/ { fm++; if (fm>=2) exit; next }
    fm==1 {
      if (match($0, "^"key":[[:space:]]*")) {
        val = substr($0, RLENGTH+1)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", val)
        print val
        exit
      }
    }
  ' "$1"
}

# ---------------------------------------------------------------------------
# Ship-mode gate
# ---------------------------------------------------------------------------
if [[ "$MODE" == "ship" ]]; then
  echo "Ship mode: verifying every chapter has status=ship-ready..."
  NOT_READY=()
  for f in "${CHAPTER_FILES[@]}"; do
    status="$(fm_get "$f" status)"
    if [[ "$status" != "ship-ready" ]]; then
      NOT_READY+=("$(basename "$f") → status=${status:-<missing>}")
    fi
  done
  if (( ${#NOT_READY[@]} > 0 )); then
    echo "ERROR: ship build refused. Chapters not ship-ready:" >&2
    for item in "${NOT_READY[@]}"; do echo "  - $item" >&2; done
    exit 1
  fi
  echo "All chapters ship-ready."
fi

# ---------------------------------------------------------------------------
# Strip frontmatter + assemble manuscript
# ---------------------------------------------------------------------------
TMPDIR="$(mktemp -d "${TMPDIR:-/tmp}/book-export-XXXXXX")"
trap 'rm -rf "$TMPDIR"' EXIT

MANUSCRIPT="$TMPDIR/manuscript.md"
: > "$MANUSCRIPT"

strip_fm() {
  # Remove YAML frontmatter (opening ---\n...\n--- block at start of file).
  awk '
    BEGIN { in_fm=0; done_fm=0 }
    NR==1 && /^---$/ { in_fm=1; next }
    in_fm && /^---$/ { in_fm=0; done_fm=1; next }
    in_fm { next }
    { print }
  ' "$1"
}

for f in "${CHAPTER_FILES[@]}"; do
  num="$(fm_get "$f" chapter)"
  title="$(fm_get "$f" title)"
  [[ -z "$title" ]] && title="$(basename "$f" .md)"

  # Page break before every chapter except the first
  if [[ -s "$MANUSCRIPT" ]]; then
    printf '\n\n\\newpage\n\n' >> "$MANUSCRIPT"
  fi

  # Strip leading # heading inside the chapter; we inject our own \chapter{}
  # so pandoc's TOC and running heads pull from our title cleanly.
  printf '\\chapter{%s}\n\n' "$title" >> "$MANUSCRIPT"

  strip_fm "$f" | awk '
    BEGIN { seen_h1=0 }
    /^# / && !seen_h1 { seen_h1=1; next }   # drop the first H1 (already injected as \chapter{})
    { print }
  ' >> "$MANUSCRIPT"
done

echo "Assembled $(wc -l <"$MANUSCRIPT" | tr -d ' ') lines."

# ---------------------------------------------------------------------------
# Render header + titlepage (expand $if(draft)$ ourselves since we are not
# using pandoc's template engine for these includes)
# ---------------------------------------------------------------------------
DRAFT_FLAG=0
[[ "$MODE" == "preview" ]] && DRAFT_FLAG=1
BUILDDATE="$(date '+%Y-%m-%d')"

render_tex() {
  local src="$1" dst="$2"
  if (( DRAFT_FLAG )); then
    sed -e 's#\$if(draft)\$##g' \
        -e 's#\$endif\$##g' \
        -e "s#\\\$builddate\\\$#$BUILDDATE#g" \
        "$src" > "$dst"
  else
    # Drop everything between $if(draft)$ and $endif$ markers
    awk '
      /\$if\(draft\)\$/ { skip=1; next }
      /\$endif\$/ { skip=0; next }
      !skip { print }
    ' "$src" | sed -e "s#\\\$builddate\\\$#$BUILDDATE#g" > "$dst"
  fi
}

HEADER_TEX="$TMPDIR/book-header.tex"
TITLE_TEX="$TMPDIR/titlepage.tex"
render_tex "$TEMPLATES_DIR/book-header.tex" "$HEADER_TEX"
render_tex "$TEMPLATES_DIR/titlepage.tex"   "$TITLE_TEX"

# ---------------------------------------------------------------------------
# Output paths
# ---------------------------------------------------------------------------
if [[ "$MODE" == "preview" ]]; then
  PDF_OUT="$EXPORT_DIR/book-preview.pdf"
  EPUB_OUT="$EXPORT_DIR/book-preview.epub"
else
  PDF_OUT="$EXPORT_DIR/book.pdf"
  EPUB_OUT="$EXPORT_DIR/book.epub"
fi
BUILD_LOG="$EXPORT_DIR/.build.log"

# ---------------------------------------------------------------------------
# Invoke pandoc → PDF
# ---------------------------------------------------------------------------
echo "Building $PDF_OUT ..."
set +e
pandoc "$MANUSCRIPT" \
  -f markdown+smart+fenced_divs+raw_tex+yaml_metadata_block \
  -o "$PDF_OUT" \
  --pdf-engine=xelatex \
  --toc --toc-depth=1 \
  --top-level-division=chapter \
  -V documentclass=book \
  -V classoption=11pt,openright,oneside \
  -V geometry=paperwidth=6in,paperheight=9in,inner=0.9in,outer=0.7in,top=0.85in,bottom=0.85in,headheight=14pt,headsep=18pt \
  -V lang=en-US \
  -V title-meta="Builder-Leader: The AI Exoskeleton That Crosses the Gap" \
  -V author-meta="Justin Johnson" \
  --include-in-header="$HEADER_TEX" \
  --include-before-body="$TITLE_TEX" \
  2> "$BUILD_LOG"
PANDOC_RC=$?
set -e

if (( PANDOC_RC != 0 )); then
  echo "ERROR: pandoc exited $PANDOC_RC. Tail of $BUILD_LOG:" >&2
  tail -40 "$BUILD_LOG" >&2
  exit $PANDOC_RC
fi

# ---------------------------------------------------------------------------
# Optional EPUB
# ---------------------------------------------------------------------------
if (( WANT_EPUB )); then
  echo "Building $EPUB_OUT ..."
  pandoc "$MANUSCRIPT" \
    -f markdown+smart+fenced_divs+raw_tex \
    -o "$EPUB_OUT" \
    --toc --toc-depth=1 \
    --top-level-division=chapter \
    -V title="Builder-Leader" \
    -V subtitle="The AI Exoskeleton That Crosses the Gap" \
    -V author="Justin Johnson" \
    -V lang=en-US \
    2>> "$BUILD_LOG"
fi

# ---------------------------------------------------------------------------
# Report
# ---------------------------------------------------------------------------
if command -v pdfinfo >/dev/null 2>&1; then
  PAGES="$(pdfinfo "$PDF_OUT" 2>/dev/null | awk '/^Pages:/{print $2}')"
else
  PAGES="?"
fi
SIZE="$(du -h "$PDF_OUT" | cut -f1)"

echo
echo "Done."
echo "  Mode:       $MODE"
echo "  Chapters:   ${#CHAPTER_FILES[@]}"
echo "  PDF:        $PDF_OUT ($SIZE${PAGES:+, $PAGES pages})"
(( WANT_EPUB )) && echo "  EPUB:       $EPUB_OUT"
echo "  Log:        $BUILD_LOG"
