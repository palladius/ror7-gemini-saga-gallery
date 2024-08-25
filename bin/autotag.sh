#!/bin/bash

#########
# Copied on 25aug24 from ror7-tailwind-puffintours, which in turn was..
# Copied on ??? from DHH vanilla 701 and redone WELL.
# Using proper variables.
# Set up on Cloud Build script:
# * _GCLOUD_REGION
# * _PROJECT_ID (needed)
# * _REGION         (redundant)
# * _MESSAGGIO_OCCASIONALE (for fun)
# TODO: export APP_NAME='puffintours'

set -euo pipefail

echo '🚗🏷️ [AutoTag] Riccardo Getting APP_NAME and SKAFFOLD_DEFAULT_REPO from config..'
echo "🚗🏷️ [AutoTag] APP_NAME=$APP_NAME"
echo "🚗🏷️ [AutoTag] SKAFFOLD_DEFAULT_REPO=$SKAFFOLD_DEFAULT_REPO"
echo "🚗🏷️ [AutoTag] FINAL_AR_IMAGE_WITHOUT_TAG=$FINAL_AR_IMAGE_WITHOUT_TAG"

#export APP_NAME='puffintours'
#SKAFFOLD_DEFAULT_REPO="europe-west1-docker.pkg.dev/puffin-tours/${APP_NAME}/${APP_NAME}"

export GIT_STATE="$(git rev-list -1 HEAD --abbrev-commit)"
export GIT_COMMIT_SHA="$(git rev-parse HEAD)" # big commit
export GIT_SHORT_SHA="${GIT_COMMIT_SHA:0:7}" # first 7 chars: Riccardo reproducing what CB does for me.
export APP_VERSION="$(cat VERSION)"

echo "🚗🏷️ [AutoTag] GIT_SHORT_SHA=$GIT_SHORT_SHA (had a bug in v0.4.9)"
echo "🚗🏷️ [AutoTag] SHORT_SHA=$SHORT_SHA"

set -x

# echo '1. Vediamo che immagini DHH-iane ci siano (BEFORE)..'
# docker images | grep puffin

echo '🚗🏷️ [AutoTag] Tagging and pushing..'
docker tag "$FINAL_AR_IMAGE_WITHOUT_TAG:sha-$GIT_SHORT_SHA" "$FINAL_AR_IMAGE_WITHOUT_TAG:v$APP_VERSION" ||
    docker tag "$FINAL_AR_IMAGE_WITHOUT_TAG:sha-$SHORT_SHA" "$FINAL_AR_IMAGE_WITHOUT_TAG:v$APP_VERSION" ||
        echo I hope either works..
docker push "$FINAL_AR_IMAGE_WITHOUT_TAG" --all-tags


# echo '3. Vediamo che immagini DHH-iane ci siano (AFTER)..'
# docker images | grep dhh
echo '🚗🏷️ [AutoTag] Done.'
