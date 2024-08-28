#!/bin/bash

set -euo pipefail

# this should ALWAYS exec for debug reasons..
touch ZZZ-todo.touch

REGION="$1"
echo "Testing ENV: REGION=$REGION"

echo gcloud auth configure-docker "${REGION}-docker.pkg.dev" &&
    touch .terraform.configured-docker-in-region-${REGION}.touch ||
        touch .terraform.error-configuring-docker-in-region-${REGION}.touch            "
