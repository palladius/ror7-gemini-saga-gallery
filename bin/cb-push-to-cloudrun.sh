#!/bin/bash

# copied from  dhh-vanilla-701/bin/cb-push-to-cloudrun.sh

# echo TODO ricc this is currently BROKEN - adding for ease of multi-computer editing.
# echo FIX ME when all the rest is fixed. For now I return 0 since sometimes CB tags images only if ALL succeeds.
# exit 0

#####################################################################################################
# Since CB doesnt have access to a number of vars, I'm trying to add them as secret
# AND THEN retrieve them from CB. If it works locally, it should hopefully also work remotely
# As long as CB has access to those secrets (CB SA was enabled to read secrets).
#####################################################################################################

export DEPLOY_VERSION='1.0.3_27aug24'

set -euo pipefail

################################################
# ENV set
################################################
export GIT_STATE="$(git rev-list -1 HEAD --abbrev-commit)"
export GIT_COMMIT_SHA="$(git rev-parse HEAD)" # big commit
export GIT_SHORT_SHA="${GIT_COMMIT_SHA:0:7}" # first 7 chars: Riccardo reproducing what CB does for me.
export APP_VERSION="$(cat VERSION)"
export GCLOUD_REGION="europe-west1" # e vabbe
export CLOUD_RUN_APP_NAME="saga-gallery-cbpush-prod"
# get from secret manager
#SECRET_REGION=$(gcloud secrets versions access latest --secret=GCLOUD_REGION)

# Derived info
CLOUDRUN_PROJECT_ID="$PROJECT_ID"
# VER non lo posso calcolare da CB vanilla, serve un shell script :/
UPLOADED_IMAGE_WITH_VER="europe-west1-docker.pkg.dev/ror-goldie/ror7-gemini-saga-gallery/saga-gallery:v$APP_VERSION"
UPLOADED_IMAGE_WITH_SHA="europe-west1-docker.pkg.dev/ror-goldie/ror7-gemini-saga-gallery/saga-gallery:sha-$GIT_SHORT_SHA"

# # $1 can be unbound
# if [ latest = "${1:-sthElse}" ]; then
#   echo Overriding the version to LATEST:
#   export UPLOADED_IMAGE_WITH_SHA="${GCLOUD_REGION}-docker.pkg.dev/${PROJECT_ID}/dhh-vanilla-701/dhh-vanilla-701:latest"
# fi

echo "---- DEBUG  ----"
echo "DEPLOY_VERSION:   $DEPLOY_VERSION"
echo "APP_VERSION:   $APP_VERSION"
echo "GIT_SHORT_SHA: $GIT_SHORT_SHA"
echo "UPLOADED_IMAGE_WITH_VER: $UPLOADED_IMAGE_WITH_VER"
echo "UPLOADED_IMAGE_WITH_SHA: $UPLOADED_IMAGE_WITH_SHA"
echo "---- /DEBUG ----"

# source = now I have all info here even without direnv :)
# This exposes REGION, ONRAMP_ENV, APP_VERSION, REGION, GIT_STATE
#source .envrc.from-gcs

set -x

#################################################################
# TODO(ricc): remove the clutter when this is proven to work.
#################################################################
# Note from Marc: this is not needed since its baked into CB
# --set-env-vars="APP_VERSION=$APP_VERSION" \
# Not used anymore
#--set-env-vars="APPLICATION_DEFAULT_CREDENTIALS=/sa.json" \
#################################################################

# limits:
#             cpu: 2000m
#             memory: 2Gi
# Previous errors:
# ERROR: (gcloud.beta.run.deploy) spec.template.spec.containers[0].resources.limits.memory: Invalid value specified for container memory. For 8.0 CPU, memory must be between 4Gi and 32Gi inclusive.

gcloud --project "$CLOUDRUN_PROJECT_ID" \
    beta run deploy "$CLOUD_RUN_APP_NAME" \
      --image    "$UPLOADED_IMAGE_WITH_VER" \
      --platform managed \
      --memory "8Gi" \
      --cpu "8" \
      --region   "$GCLOUD_REGION" \
      --set-env-vars='description=created-from-bin-slash-cb-push-to-cloudrun-sh' \
      --set-env-vars='fav_color=teal' \
      --set-env-vars="GIT_STATE=$GIT_STATE" \
      --set-env-vars="APP_VERSION=$APP_VERSION" \
      --set-env-vars="RAILS_MASTER_KEY=$RAILS_MASTER_KEY" \
      --set-env-vars="RAILS_ENV=production" \
      --set-env-vars="RAILS_SERVE_STATIC_FILES=true" \
      --set-env-vars="MESSAGGIO_OCCASIONALE=Feel free to overwrite me on Cloud Run from UI for your dirty messages.." \
      --set-env-vars="RAILS_LOG_TO_STDOUT=yesplease" \
      --allow-unauthenticated

#      --set-env-vars="SECRET_KEY_BASE=" \


# make sure we exit 0 with a string (set -e guarantees this)
echo 'All is Done well like Locatelli.'


