#!/bin/bash
set -euo pipefail
source _demo_helpers.sh

h1 "Some example sboms..."

pause-then-run "ls -l sboms"

SBOM="sboms/$(ls sboms/ | head -1)"

show-vars SBOM

pause-then-run 'head -12 $SBOM'

pause-then-run 'grep pkg:golang $SBOM | head -5'

pause-then-run 'grep pkg:rpm $SBOM | head -5'

h1 "Some rego..."

pause

show-rego "policy/hello_world.rego"

h1 "A conforma policy.yaml..."

pause

show-yaml "policy.yaml"

h1 "Put it together..."

pause-then-run 'ec validate input $SBOM --policy policy.yaml'

pause-then-run 'ec validate input $SBOM --policy policy.yaml --show-successes'

pause-then-run 'ec validate input $SBOM --policy policy.yaml --show-successes --info'

pause-then-run 'ec validate input $SBOM --policy policy.yaml --output json | jq'

pause

show-msg '"But all this is old stuff.. show me something new!"'

h1 "Conforma as a web service"

show-bash bin/start-service.sh

pause "(Run that in another terminal.)"

pause-then-run 'curl -s \
    -X POST \
    -H "Content-Type: application/json" \
    --data-binary @"$SBOM" \
    "http://localhost:8080/v1/validate/input" | jq'

pause-then-run 'for s in sboms/*; do
    printf "\n$s\n\n";
    curl -sX POST -H "Content-Type: application/json" --data-binary @"$s" \
      "http://localhost:8080/v1/validate/input" \
      | jq | head -8
  done'

h1 "One more trick..."

show-msg "If you just need a pass/fail or a red/green signal:"

pause-then-run 'curl -s \
    -X POST \
    -H "Content-Type: application/json" \
    --data-binary @"$SBOM" \
    --output /dev/null \
    --dump-header - \
    "http://localhost:8080/v1/validate/input"'

pause-then-run 'for s in sboms/*; do
    printf "\n$s\n";
    curl -sX POST -H "Content-Type: application/json" --data-binary @"$s" \
      --output /dev/null \
      --dump-header - \
      "http://localhost:8080/v1/validate/input" \
      | grep X-Conforma-Result
  done'
