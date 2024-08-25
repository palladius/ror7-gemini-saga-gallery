#!/bin/bash

# To be submitted by Riccardo locally with hydrated vars which are NOT available solely on gihtub
echodo gcloud --project "$PROJECT_ID" builds submit --config=cloudbuild.yaml \
    --substitutions=TAG_NAME="test"
