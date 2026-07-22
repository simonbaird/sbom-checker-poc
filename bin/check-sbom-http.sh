#!/bin/bash
set -euo pipefail

INPUT_FILE="$1"
CONFORMA_SERVICE=http://localhost:8080/v1

curl -s \
  -X POST \
  -H 'Content-Type: application/json' \
  --data-binary @"$INPUT_FILE" \
  "$CONFORMA_SERVICE/validate/input" \
  | jq
