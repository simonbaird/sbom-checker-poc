#!/bin/bash
set -euo pipefail

# Fetch the sbom for one particular image and store it locally
IMG_REF="$1"

# Use skopeo to find the image digest
DIGEST=$(skopeo inspect --no-tags docker://$IMG_REF --format "{{.Digest}}")
PINNED_REF="${IMG_REF%:*}@$DIGEST"

# Generate the file name based on the image ref and digest
OUTPUT_DIR="${2:-sboms}"
SBOM_FILE="${OUTPUT_DIR}/$(echo "$PINNED_REF" | sed 's/[\/@:]/__/g').json"

# Download the sbom
mkdir -p "$OUTPUT_DIR"
cosign download sbom "$PINNED_REF" > "$SBOM_FILE"
