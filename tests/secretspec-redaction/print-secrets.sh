#!/usr/bin/env bash
set -eu

printf 'TOKEN=%s\n' "$TEST_TOKEN"
printf 'FILE='
cat "$TEST_FILE"
printf '\n'
# Separate writes exercise the streaming state across PTY reads.
printf 'SPLIT='
printf '%s' "$TEST_TOKEN" | dd bs=1 count=8 2>/dev/null
sleep 0.1
printf '%s\n' "$TEST_TOKEN" | dd bs=1 skip=8 2>/dev/null
printf 'REDACTION_DONE\n'
