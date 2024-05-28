#!/bin/bash

# Define the path to the file where the currently deployed version is stored
CURRENT_VERSION_FILE="./apps-helm-chart/prod/postsyncjob/current_version.txt"

# Fetch the latest tags from the remote repository
git fetch --tags

# Get the latest tag name
LATEST_TAG=$(git describe --tags `git rev-list --tags --max-count=1`)

# Read the currently deployed version
CURRENT_VERSION=$(cat "$CURRENT_VERSION_FILE")

# Compare the latest tag with the currently deployed version
if [ "$LATEST_TAG" != "$CURRENT_VERSION" ]; then
  echo "A new version ($LATEST_TAG) is deployed. Current version is $CURRENT_VERSION."
  # Update the currently deployed version
  echo $LATEST_TAG > "$CURRENT_VERSION_FILE"
  # Add custom logic here to handle the new version deployment
else
  echo "No new version deployed. Current version is $CURRENT_VERSION."
fi