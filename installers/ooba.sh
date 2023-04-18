#!/bin/bash
# This script is used to install the Ooba application
XFORMERS_WHL=$1
# Set the environment variables
INSTALL_DIR="${INSTALL_DIR:-${HOME}/ooba}"
CUDA_HOME="${CUDA_HOME:-/usr/local/cuda-11.7}"
CUDA_VERSION="${CUDA_VERSION:-117}"

# Function to display progress messages
progress() {
  echo -e "\e[1;32m>>>\e[0m \e[1;33m$1\e[0m"
}

set -e

# copy example service to systemd
progress "Copying systemd service file..."
sudo cp ../systemd/ooba.service.example /etc/systemd/system/ooba.service

# clone the repository
progress "Cloning the Ooba repository..."
git clone https://github.com/oobabooga/text-generation-webui.git "${INSTALL_DIR}"
cd "${INSTALL_DIR}"

# create the virtual environment
progress "Creating virtual python environment..."
python -m venv venv
source venv/bin/activate

# install the matching cuda version of pytorch and torchvision
progress "Installing PyTorch, TorchVision, and TorchAudio for CUDA ${CUDA_VERSION}..."
pip install torch torchvision torchaudio --extra-index-url "https://download.pytorch.org/whl/cu${CUDA_VERSION}"

# install the requirements
progress "Installing other Python dependencies..."
pip install -r requirements.txt

# download a small default model
progress "Downloading a default model..."
python download-model.py facebook/opt-1.3b

# create default repository directory
mkdir -p "${INSTALL_DIR}/repositories"

# Build custom pytorch
if [ ${CUDA_VERSION} -gt 118 ]; then
  progress "Building custom PyTorch for CUDA ${CUDA_VERSION}..."
  git clone --recursive https://github.com/pytorch/pytorch "${INSTALL_DIR}/repositories/pytorch"
  cd "${INSTALL_DIR}/repositories/pytorch"
  git submodule sync
  git submodule update --init --recursive
  conda update -n base -c defaults conda -y
  conda create -n torch-${CUDA_VERSION}
  conda activate torch-${CUDA_VERSION}
  conda install cmake ninja -y
  pip install -r requirements.txt
  conda install mkl mkl-include -y
  conda install -c pytorch magma-cuda${CUDA_VERSION} -y
  export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
  python setup.py develop
  # What comes next?
fi



# Install GPTQ support for 4bit 128g LLaMA
progress "Installing GPTQ for LLaMA..."
cd "${INSTALL_DIR}/repositories"
git clone https://github.com/oobabooga/GPTQ-for-LLaMa.git -b cuda
cd GPTQ-for-LLaMa
pip install torch torchvision --extra-index-url "https://download.pytorch.org/whl/cu${CUDA_VERSION}"
python setup_cuda.py install
cd "${INSTALL_DIR}"

# Install xformers for extra speed and memory efficiency
if [ -e ${XFORMERS_WHL} ]; then
  progress "Building xformers (this can take a really long time)..."
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
  export XFORMERS_WHL="${INSTALL_DIR}/repositories/xformers/dist/*.whl"
fi
progress "Installing xformers wheel..."
cd "${INSTALL_DIR}"
source venv/bin/activate
pip install ${XFORMERS_WHL}

progress "Ooba application installation complete!"
