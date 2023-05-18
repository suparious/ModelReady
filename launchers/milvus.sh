#!/bin/bash
INSTALL_DIR="${INSTALL_DIR:-${HOME}/milvus}"

# Get the latest release tag from Milvus GitHub
LATEST_RELEASE=$(curl --silent "https://api.github.com/repos/milvus-io/milvus/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Look for configuration directory
if [ ! -d ${INSTALL_DIR} ]; then
  progress "Unable to locate configuration in ${INSTALL_DIR}... Did you run the installer?"
  exit 1
fi

# Download the Docker Compose file for the latest release
wget https://github.com/milvus-io/milvus/releases/download/${LATEST_RELEASE}/milvus-standalone-docker-compose.yml -O "${INSTALL_DIR}/docker-compose.yml"

# Start Milvus using Docker Compose
cd "${INSTALL_DIR}"
docker compose up -d
