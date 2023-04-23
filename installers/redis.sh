#!/bin/bash

# Function to display progress messages
progress() {
  echo -e "\e[1;32m>>>\e[0m \e[1;33m$1\e[0m"
}

set -e

# copy example service to systemd
if [ ! -f /etc/systemd/system/redis-server.service ]; then
  progress "Copying systemd service file..."
  sudo cp ../systemd/redis-server.service.example /etc/systemd/system/redis-server.service
fi

if [ -f /usr/local/bin/redis-server ]; then
  progress "Redis is already installed, please uninstall it first."
  exit 1
else
  # Download and build Redis
  progress "Downloading and building Redis..."
  wget https://download.redis.io/redis-stable.tar.gz
  tar -xzvf redis-stable.tar.gz
  cd redis-stable
  make

  # Test Redis
  progress "Testing Redis..."
  make test

  # Install Redis
  progress "Installing Redis..."
  sudo make install
fi

progress "Redis server installation complete!"

echo " To expose this service on your network, with no security, then \
use redis-cli to:
CONFIG SET protected-mode no
CONFIG REWRITE
"
