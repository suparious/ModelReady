#!/bin/bash
## A script to install the Milvus Forwarder application for kubernetes standalone or cluster deployments
## This is not required for Docker deployments

# Function to display progress messages
progress() {
  echo -e "\e[1;32m>>>\e[0m \e[1;33m$1\e[0m"
}

set -e

# copy example service to systemd
if [ ! -f /etc/systemd/system/milvus-forwarder.service ]; then
  progress "Copying systemd service file..."
  sudo cp ../systemd/milvus-forwarder.service.example /etc/systemd/system/milvus-forwarder.service
  sudo sed -i "s/YOUR_USERNAME/${USER}/g" /etc/systemd/system/milvus-forwarder.service
fi

progress "Milvus server installation complete!"
progress "               configure the systemd service: /etc/systemd/system/milvus-forwarder.service"
progress "         Once the service is configured, run: sudo systemctl daemon-reload"
progress "               To start the application, run: sudo systemctl start milvus-forwarder"
progress "enable the application to start on boot, run: sudo systemctl enable milvus-forwarder"
progress "           To view the application logs, run: sudo journalctl -u milvus-forwarder -f"
