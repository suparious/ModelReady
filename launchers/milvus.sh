#!/bin/bash
INSTALL_DIR="${INSTALL_DIR:-${HOME}/milvus}"

# Look for configuration directory
if [ ! -d ${INSTALL_DIR} ]; then
  echo "Unable to locate configuration in ${INSTALL_DIR}... Did you run the installer?"
  exit 1
fi

# Start Milvus using Docker Compose
cd "${INSTALL_DIR}"
docker-compose up -d

# Get the name or ID of the Milvus Docker container
#MILVUS_CONTAINER=$(docker-compose ps -q)

# Define the name of the Milvus Docker service
MILVUS_SERVICE="milvus"

# Continuously check if the Milvus Docker container is running
while true; do
  #if ! docker ps --format '{{.Names}}' | grep -q "^${MILVUS_CONTAINER}$"; then
  if ! docker ps --format '{{.Names}}' | grep -q "^${MILVUS_SERVICE}_"; then
    echo "Milvus Docker container has stopped."
    exit 1
  fi
  sleep 5
done
