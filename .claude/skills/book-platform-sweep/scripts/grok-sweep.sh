#!/usr/bin/env bash
# Book wrapper. Usage: grok-sweep.sh <chapter-slug> <query>
SLUG="$1"; shift
exec ${TOPIC_SWEEP_ROOT:-/path/to/topic-platform-sweep}/grok-sweep.sh \
  "${BOOK_ROOT:-$PWD}/research/${SLUG}" "$SLUG" "$@"
