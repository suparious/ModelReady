#!/bin/bash
# This script is used to install the Ooba application
# Set the environment variables
INSTALL_DIR="${HOME}/ooba"
PYENV_VERSION="3.11.3"
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
# install the matching cuda version of pytorch and torchvision
pip install torch torchvision torchaudio --extra-index-url "https://download.pytorch.org/whl/cu${CUDA_VERSION}"
# install the requirements
pip install -r requirements.txt
# download a small default model
python download-model.py facebook/opt-1.3b
# Install GPTQ support for 4bit 128g LLaMA
echo "Installing GPTQ..."
cd "${INSTALL_DIR}/repositories"
git clone https://github.com/oobabooga/GPTQ-for-LLaMa.git -b cuda
cd GPTQ-for-LLaMa
python setup_cuda.py install
cd "${INSTALL_DIR}"
# Install xformers for extra speed and memory efficiency
echo "This can take a while..."
cd "${INSTALL_DIR}/repositories"
git clone https://github.com/facebookresearch/xformers.git
cd xformers
git submodule update --init --recursive
python -m venv venv
source venv/bin/activate
pip install torch torchvision --extra-index-url "https://download.pytorch.org/whl/cu${CUDA_VERSION}"
pip install -r requirements.txt
pip install wheel
python setup.py build
python setup.py bdist_wheel
deactivate
cd "${INSTALL_DIR}"
source venv/bin/activate
pip install ${INSTALL_DIR}/repositories/xformers/dist/*.whl
