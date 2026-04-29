#!/usr/bin/env bash
# Book wrapper around synth-quick.sh (Tier-3 spot-check; real Tier 3 = Opus subagent).
# Usage: synth-chapter.sh <chapter-slug>
SLUG="$1"
exec ${TOPIC_SWEEP_ROOT:-/path/to/topic-platform-sweep}/synth-quick.sh \
  "${BOOK_ROOT:-$PWD}/research/${SLUG}" "$SLUG"
