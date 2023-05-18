#!/bin/bash
INSTALL_DIR="${INSTALL_DIR:-${HOME}/milvus}"

# Look for configuration directory
if [ ! -d ${INSTALL_DIR} ]; then
  progress "Unable to locate configuration in ${INSTALL_DIR}... Did you run the installer?"
  exit 1
fi

# Start Milvus using Docker Compose
cd "${INSTALL_DIR}"
docker compose up -d
