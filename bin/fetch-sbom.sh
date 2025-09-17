#!/bin/bash
set -euo pipefail

IMG_REF="$1"
DIGEST=$(skopeo inspect --no-tags docker://$IMG_REF --format "{{.Digest}}")
PINNED_REF="${IMG_REF%:*}@$DIGEST"

OUTPUT_DIR="${2:-sboms}"
SBOM_FILE="${OUTPUT_DIR}/$(echo "$PINNED_REF" | sed 's/[\/@:]/__/g').json"

mkdir -p "$OUTPUT_DIR"
cosign download sbom "$PINNED_REF" > "$SBOM_FILE"
