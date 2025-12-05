#!/bin/bash
set -euo pipefail

# Demonstrating how to use Conforma to evaluate policy checks
# against an sbom file. Run `ec validate input --help` for more
# info about the available flags.

ec validate input \
  --file "$1" \
  --policy "${2:-policy.yaml}" \
  --output yaml \
  --show-successes=1 \
  --info | yq
