#!/usr/bin/env bash
# Book wrapper. Usage: gemini-sweep.sh <chapter-slug> <query>
SLUG="$1"; shift
exec ${TOPIC_SWEEP_ROOT:-/path/to/topic-platform-sweep}/gemini-sweep.sh \
  "${BOOK_ROOT:-$PWD}/research/${SLUG}" "$SLUG" "$@"
