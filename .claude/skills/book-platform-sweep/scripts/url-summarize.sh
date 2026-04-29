#!/usr/bin/env bash
# Book wrapper. Usage: url-summarize.sh <chapter-slug>
SLUG="$1"
exec ${TOPIC_SWEEP_ROOT:-/path/to/topic-platform-sweep}/url-summarize.sh \
  "${BOOK_ROOT:-$PWD}/research/${SLUG}" "$SLUG"
