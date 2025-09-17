#!/bin/bash
set -euo pipefail

ec validate input \
  --file "$1" \
  --policy "${2:-policy.yaml}" \
  --output yaml \
  --show-successes=1 \
  --info | yq
