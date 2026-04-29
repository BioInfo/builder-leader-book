#!/usr/bin/env bash
# Re-run ONLY the Gemini portion of Tier 2 discovery for one chapter.
# Used to backfill chapters whose gemini-discovery files came out empty
# because of the jq/thoughtSignature parse bug (fixed during development).
#
# Usage: gemini-discovery-only.sh <chapter-slug> <prompt>
set -e
SLUG="$1"; shift
PROMPT="$1"
DATE=$(date +%Y-%m-%d)
SINCE=$(date -v-90d +%Y-%m-%d)
DIR="${BOOK_ROOT:-$PWD}/research/${SLUG}/_raw-discovery"
mkdir -p "$DIR"

GEM=$(security find-generic-password -s 'gemini-api-key' -w 2>/dev/null || pass api-keys/gemini | head -1)

RECENCY_PREAMBLE="TODAY'S DATE IS ${DATE}. Your knowledge cutoff is irrelevant. Use live web search to find ONLY items dated after ${SINCE} (last 90 days). Reject and DO NOT include any item dated before ${SINCE}. If you cannot find recent items in some category, say so explicitly rather than substituting older ones. Cite the publication date next to every item."
RECENCY_REMINDER="REMINDER: Today is ${DATE}. Reject anything dated before ${SINCE}. Every item must have a date and that date must be after ${SINCE}."

ANCHORED_PROMPT="${RECENCY_PREAMBLE}

${PROMPT}

${RECENCY_REMINDER}"

OUT_G="$DIR/gemini-discovery-${DATE}.md"
# If existing file is empty (just prompt header), rename to -broken and regenerate
if [[ -f "$OUT_G" ]] && [[ $(wc -l < "$OUT_G") -lt 30 ]]; then
  mv "$OUT_G" "${OUT_G%.md}-broken.md"
fi

{
  echo "# Gemini 3 Flash grounded (discovery) — ${SLUG} — ${DATE}"
  echo "**Prompt:**"
  echo '```'
  echo "$PROMPT"
  echo '```'
  echo ""
  echo "---"
  echo ""
} > "$OUT_G"

GEM_BODY=$(python3 -c "import json,sys; print(json.dumps({'contents':[{'parts':[{'text':sys.argv[1]}]}],'tools':[{'google_search':{}}]}))" "$ANCHORED_PROMPT")
GRESP_FILE=$(mktemp)
curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent?key=${GEM}" \
  -H "Content-Type: application/json" \
  -d "$GEM_BODY" > "$GRESP_FILE"

python3 - "$GRESP_FILE" "$OUT_G" <<'PYEOF'
import json, sys
resp_path, out_path = sys.argv[1], sys.argv[2]
try:
    d = json.load(open(resp_path))
except Exception as e:
    with open(out_path, 'a') as f:
        f.write(f"\n[parser error: {e}]\n")
    sys.exit(0)
with open(out_path, 'a') as f:
    if 'error' in d:
        f.write(f"\n[API error: {d['error'].get('message','unknown')}]\n")
        sys.exit(0)
    for c in d.get('candidates', []):
        for p in c.get('content', {}).get('parts', []):
            if 'text' in p:
                f.write(p['text'])
                f.write("\n")
    f.write("\n\n## Grounding sources\n\n")
    for c in d.get('candidates', []):
        for ch in c.get('groundingMetadata', {}).get('groundingChunks', []):
            uri = ch.get('web', {}).get('uri', '')
            title = ch.get('web', {}).get('title', '')
            if uri:
                f.write(f"- {title}: {uri}\n" if title else f"- {uri}\n")
PYEOF
rm -f "$GRESP_FILE"

lines=$(wc -l < "$OUT_G" | tr -d ' ')
echo "OK: $SLUG -> $OUT_G ($lines lines)"
