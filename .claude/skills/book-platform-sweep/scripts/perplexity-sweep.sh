#!/usr/bin/env bash
# Book wrapper around topic-platform-sweep/scripts/perplexity-sweep.sh
# Usage: perplexity-sweep.sh <chapter-slug> <query>
SLUG="$1"; shift
exec ${TOPIC_SWEEP_ROOT:-/path/to/topic-platform-sweep}/perplexity-sweep.sh \
  "${BOOK_ROOT:-$PWD}/research/${SLUG}" "$SLUG" "$@"
