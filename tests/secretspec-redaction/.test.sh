#!/usr/bin/env bash
set -eu

export DEVENV_NO_AI_AGENT=1

devenv-run-tests pty redaction.typescript "devenv shell" >/dev/null <<'SCRIPT'
expect:REDACTION_SHELL_READY
send:./print-secrets.sh\n
expect:TOKEN=[REDACTED]
expect:FILE=[REDACTED]
expect:SPLIT=[REDACTED]
expect:REDACTION_DONE
send:exit\n
SCRIPT

if grep -aFq 'fixture-shell-token' redaction.typescript ||
   grep -aFq 'fixture-file-contents' redaction.typescript; then
  echo "SecretSpec values reached the terminal transcript" >&2
  exit 1
fi
