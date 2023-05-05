#!/bin/bash

UNSTABLE=$1
REPO="Significant-Gravitas/Auto-GPT"

# Clone the repository if it doesn't exist
if [ ! -d "$(basename "$REPO")" ]; then
  git clone "https://github.com/$REPO.git"
fi

# Update the repository
cd "$(basename "$REPO")"
git fetch

if [ "${UNSTABLE}" == "--unstable" ]; then
  git checkout master
  echo "Running version master"
  bash run.sh -c -l 1 --allow-downloads --install-plugin-deps
else
  # Get the latest release tag from the GitHub API
  LATEST_TAG=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" \
    | grep '"tag_name":' \
    | sed -E 's/.*"([^"]+)".*/\1/')
    
  # Check if the tag was fetched successfully
  if [ -z "$LATEST_TAG" ]; then
    echo "Error: Could not fetch the latest release tag."
    exit 1
  fi
  
  # Checkout the latest release
  git checkout "$LATEST_TAG"
  echo "Running version $LATEST_TAG"
  bash run.sh -c -l 1 --allow-downloads
fi
