#!/usr/bin/env bash
# Book wrapper. Usage: discovery-sweep.sh <chapter-slug> <prompt>
SLUG="$1"; shift
exec ${TOPIC_SWEEP_ROOT:-/path/to/topic-platform-sweep}/discovery-sweep.sh \
  "${BOOK_ROOT:-$PWD}/research/${SLUG}" "$SLUG" "$@"
