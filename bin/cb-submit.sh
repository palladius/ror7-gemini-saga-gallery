#!/bin/bash
set -euo pipefail

VER="0.2"
# TODO add them to CB config :)
_GCP_REGION=$GCP_REGION
_MY_REPO_NAME=$MY_REPO_NAME
_APP_NAME=$APP_NAME
FINAL_AR_IMAGE_WITHOUT_TAG="${_GCP_REGION}-docker.pkg.dev/${PROJECT_ID}/${_MY_REPO_NAME}/${_APP_NAME}"
# TODO remove this after accepting in your heart that CB does NOT accept parametric `images:` stanza.
FINAL_AR_IMAGE_LATEST="$FINAL_AR_IMAGE_WITHOUT_TAG:latest"

#echo '1. variable _FINAL_AR_IMAGE_WITHOUT_TAG:' "${FINAL_AR_IMAGE_WITHOUT_TAG}"
#echo '2. fixed    _FINAL_AR_IMAGE_WITHOUT_TAG:' "europe-west1-docker.pkg.dev/ror-goldie/ror7-gemini-saga-gallery/saga-gallery"

# To be submitted by Riccardo locally with hydrated vars which are NOT available solely on gihtub
echodo gcloud --project "$PROJECT_ID" builds submit --config=cloudbuild.yaml \
    --substitutions=\
_MESSAGGIO_OCCASIONALE="bypassed by CLI bash in $0 v$VER",\
_FINAL_AR_IMAGE_WITHOUT_TAG="$FINAL_AR_IMAGE_WITHOUT_TAG",\
_FINAL_AR_IMAGE_LATEST="$FINAL_AR_IMAGE_LATEST"

