#!/bin/bash
set -euo pipefail

# Demonstrating how to use Conforma to evaluate policy checks
# against an sbom file. Run `ec validate input --help` for more
# info about the available flags.
#
# This starts a persistent http service.

ec validate input \
  --server \
  --policy "${2:-policy.yaml}" \
  --show-successes \
  --info
