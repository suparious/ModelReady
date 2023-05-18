#!/bin/bash
## A script to install the Milvus Standalone application for Docker deployments
## This is not required for kubernetes deployments
## This script does not use the milvus-forwarder service
export INSTALL_DIR="${INSTALL_DIR:-${HOME}/milvus}"
export GITHUB_TOKEN="${GITHUB_TOKEN:-}"

# Function to display progress messages
progress() {
  echo -e "\e[1;32m>>>\e[0m \e[1;33m$1\e[0m"
}

set -e

# Look for configuration directory
if [ ! -d ${INSTALL_DIR} ]; then
  progress "Creating configuration directory in ${INSTALL_DIR}..."
  mkdir -p "${INSTALL_DIR}"
else
  progress "Found existing configuration in ${INSTALL_DIR}..."
fi

# Download the Docker Compose file for the latest release
if [ ! -f "${INSTALL_DIR}/docker-compose.yml" ]; then
  progress "Downloading Docker Compose file for latest release..."
else
  progress "Updating existing Docker Compose file in ${INSTALL_DIR}..."
  mv "${INSTALL_DIR}/docker-compose.yml" "${INSTALL_DIR}/docker-compose.yml.bak"
fi 
# Get the latest release tag from Milvus GitHub
if [ -z ${GITHUB_TOKEN} ]; then
  echo "Attempting non-authenticated GitHub API call..."
  LATEST_RELEASE=$(curl --silent "https://api.github.com/repos/milvus-io/milvus/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
else
  echo "Attempting authenticated GitHub API call..."
  LATEST_RELEASE=$(curl --silent -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/milvus-io/milvus/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
fi

# Download the Docker Compose file for the latest release
wget https://github.com/milvus-io/milvus/releases/download/${LATEST_RELEASE}/milvus-standalone-docker-compose.yml -O "${INSTALL_DIR}/docker-compose.yml"

# copy example service to systemd
if [ ! -f /etc/systemd/system/milvus.service ]; then
  progress "Copying systemd service file..."
  sudo cp ../systemd/milvus.service.example /etc/systemd/system/milvus.service
  sudo sed -i "s/YOUR_USERNAME/${USER}/g" /etc/systemd/system/milvus.service
  sudo sed -i "s/YOUR_USERGROUP/${USER}/g" /etc/systemd/system/milvus.service
fi

progress "Milvus server installation complete!"
progress "               configure the systemd service: /etc/systemd/system/milvus.service"
progress "         Once the service is configured, run: sudo systemctl daemon-reload"
progress "               To start the application, run: sudo systemctl start milvus"
progress "enable the application to start on boot, run: sudo systemctl enable milvus"
progress "           To view the application logs, run: sudo journalctl -u milvus -f"
