#!/usr/bin/env bash
# Book wrapper. Substack pool is shared across chapters → writes to research/_shared/_raw/.
# Optional voices file at canon/voices-substack.md (book-specific) — pass to topic script if present.
# Usage: substack-pool.sh [<since-date>]
SINCE="${1:-}"
SHARED_DIR="${BOOK_ROOT:-$PWD}/research/_shared"
VOICES_FILE="${BOOK_ROOT:-$PWD}/canon/voices-substack.md"

ARGS=("$SHARED_DIR")
if [ -f "$VOICES_FILE" ]; then
  ARGS+=("$VOICES_FILE")
fi
if [ -n "$SINCE" ]; then
  # Pad voices arg if missing
  [ ${#ARGS[@]} -eq 1 ] && ARGS+=("")
  ARGS+=("$SINCE")
fi

exec ${TOPIC_SWEEP_ROOT:-/path/to/topic-platform-sweep}/substack-pool.sh "${ARGS[@]}"
