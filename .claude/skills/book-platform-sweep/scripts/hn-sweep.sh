#!/usr/bin/env bash
# Book wrapper. Usage: hn-sweep.sh <chapter-slug> <topic1> [<topic2>...]
SLUG="$1"; shift
exec ${TOPIC_SWEEP_ROOT:-/path/to/topic-platform-sweep}/hn-sweep.sh \
  "${BOOK_ROOT:-$PWD}/research/${SLUG}" "$SLUG" "$@"
