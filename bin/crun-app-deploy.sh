#!/bin/bash

set -euo pipefail

IMG=europe-west1-docker.pkg.dev/ror-goldie/ror7-gemini-saga-gallery/saga-gallery

echodo gcloud --project "$PROJECT_ID" \
    beta run deploy saga-gallery-bin-manhouse-dev \
      --image "$IMG:latest" \
      --platform managed \
      --memory "2048Mi" \
      --cpu "4" \
      --region   "$GCP_REGION" \
      --port 3000 \
      --set-env-vars='description=created-from-bin-slash-crun-app-deploy-sh' \
      --set-env-vars="RAILS_MASTER_KEY=$RAILS_MASTER_KEY" \
      --set-env-vars="RAILS_ENV=development" \
      --set-env-vars="RAILS_SERVE_STATIC_FILES=true" \
      --set-env-vars="MESSAGGIO_OCCASIONALE=Feel free to overwrite me on Cloud Run from UI for your dirty messages.." \
      --set-env-vars="RAILS_LOG_TO_STDOUT=yesplease" \
      --allow-unauthenticated

#       --set-env-vars="SECRET_KEY_BASE=" \
