#!/usr/bin/env bash
# Book wrapper. Usage: reddit-sweep.sh <chapter-slug> <sub1> [<sub2>...]
SLUG="$1"; shift
exec ${TOPIC_SWEEP_ROOT:-/path/to/topic-platform-sweep}/reddit-sweep.sh \
  "${BOOK_ROOT:-$PWD}/research/${SLUG}" "$SLUG" "$@"
