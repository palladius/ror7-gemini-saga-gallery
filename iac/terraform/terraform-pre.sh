#!/bin/bash

# Read the version from the file
app_version=$(cat ../../VERSION)

# Write the version to the tfvars file
echo "APP_VERSION = \"${app_version}\"" > terraform.tfvars
