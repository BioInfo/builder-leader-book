#!/usr/bin/env bash
# Book wrapper. Usage: reddit-content.sh <chapter-slug>
SLUG="$1"
exec ${TOPIC_SWEEP_ROOT:-/path/to/topic-platform-sweep}/reddit-content.sh \
  "${BOOK_ROOT:-$PWD}/research/${SLUG}" "$SLUG"
