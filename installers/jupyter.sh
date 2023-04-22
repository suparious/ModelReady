#!/bin/bash
JUPYTER_HOME="${HOME}/jupyter"
PYENV_VERSION="3.11.3"
# This script is used to install the Jupyter Notebook application

# Function to display progress messages
progress() {
  echo -e "\e[1;32m>>>\e[0m \e[1;33m$1\e[0m"
}

set -e

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

progress "Jupyter application installation complete!"