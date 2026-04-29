#!/usr/bin/env bash
# Book wrapper. Usage: fetch-discovery-urls.sh <chapter-slug>
SLUG="$1"
exec ${TOPIC_SWEEP_ROOT:-/path/to/topic-platform-sweep}/fetch-discovery-urls.sh \
  "${BOOK_ROOT:-$PWD}/research/${SLUG}" "$SLUG"
