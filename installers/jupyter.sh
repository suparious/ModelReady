#!/bin/bash
JUPYTER_HOME="${HOME}/jupyter"
PYENV_VERSION="3.11.3"
# This script is used to install the Jupyter Notebook application

# Function to display progress messages
progress() {
  echo -e "\e[1;32m>>>\e[0m \e[1;33m$1\e[0m"
}

set -e

# copy example service to systemd
if [ ! -f /etc/systemd/system/jupyter.service ]; then
  progress "Copying systemd service file..."
  sudo cp ../systemd/jupyter.service.example /etc/systemd/system/jupyter.service
fi

# Create the default Jupyter Notebook directory
progress "Creating python virtual environment..."
mkdir -p "${JUPYTER_HOME}"
cd "${JUPYTER_HOME}"
pyenv local "${PYENV_VERSION}"
python -m venv venv

# Install / Upgrade Jupyter Notebook
progress "Installing Jupyter apps..."
source venv/bin/activate
pip install --upgrade pip
pip install --upgrade jupyter
deactivate

# Give some instructions on next steps
progress "Jupyter application installation complete!"
progress "Please configure /etc/systemd/system/jupyter.service before trying to start the service."
progress "            Once the service is configured, run: sudo systemctl daemon-reload"
progress "                  To start the application, run: sudo systemctl start jupyter"
progress "To enable the application to start on boot, run: sudo systemctl enable jupyter"
progress "              To view the application logs, run: sudo journalctl -u jupyter -f"
