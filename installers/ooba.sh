#!/bin/bash
# This script is used to install the Ooba application

# Set the environment variables
INSTALL_DIR="${HOME}/ooba"
PYENV_VERSION="3.11.3"
PARAMS="--auto-devices --listen --threads 4 --chat --xformers"
CUDA_HOME="/usr/local/cuda-11.7"
CUDA_VERSION="117"

# clone the repository
git clone https://github.com/oobabooga/text-generation-webui.git "${INSTALL_DIR}"
cd "${INSTALL_DIR}"
# create the virtual environment
pyenv install "${PYENV_VERSION}"
pyenv shell "${PYENV_VERSION}"
python -m venv venv
source venv/bin/activate
# install the requirements
pip install torch torchvision torchaudio --extra-index-url "https://download.pytorch.org/whl/cu${CUDA_VERSION}"
pip install -r requirements.txt
python download-model.py facebook/opt-1.3b

deactivate