#!/bin/bash
# This script is used to install the Ooba application
export XFORMERS_WHL=$1
# Set the environment variables
INSTALL_DIR="${INSTALL_DIR:-${HOME}/ooba}"
CUDA_HOME="${CUDA_HOME:-/usr/local/cuda-11.8}"
CUDA_VERSION="${CUDA_VERSION:-118}"
DEFAULT_MODEL="facebook/opt-1.3b"
#export CC=/usr/bin/clang
#export CPP=/usr/bin/clang-cpp
#export CXX=/usr/bin/clang++
#export LD=/usr/bin/ld.bfd
# export CFLAGS="-O3 -march=native -mtune=native -fPIC -fno-plt -fno-stack-protector -fno-asynchronous-unwind-tables -fno-unwind-tables -fno-ident -fno-merge-constants -fno-stack-check -fno-stack-protector -fno-strict-aliasing -fno-strict-overflow -fno-merge-all-consta
export CFLAGS="-Wno-error -fno-strict-overflow"

# Function to display progress messages
progress() {
  echo -e "\e[1;32m>>>\e[0m \e[1;33m$1\e[0m"
}

set -e

# copy example service to systemd
if [ ! -f /etc/systemd/system/ooba.service ]; then
  progress "Copying systemd service file..."
  sudo cp ../systemd/ooba.service.example /etc/systemd/system/ooba.service
fi

# clone the repository
if [ ! -d ${INSTALL_DIR} ]; then
  progress "Cloning the Ooba repository..."
  git clone https://github.com/oobabooga/text-generation-webui.git "${INSTALL_DIR}"
else
  progress "Updating existing Ooba repository..."
  cd "${INSTALL_DIR}"
  git pull
fi

# create the virtual environment
progress "Creating virtual python environment..."
cd "${INSTALL_DIR}"
python -m venv venv
source venv/bin/activate

# install the requirements
progress "Installing other Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# download a small default model
progress "Downloading a default model: ${DEFAULT_MODEL}..."
python download-model.py "${DEFAULT_MODEL}"

# create default repository directory
mkdir -p "${INSTALL_DIR}/repositories"

# Build custom pytorch
if [ ${CUDA_VERSION} -gt 118 ]; then
  progress "Building custom PyTorch for CUDA ${CUDA_VERSION}..."
  if [ ! -d "${INSTALL_DIR}/repositories/pytorch" ]; then
    git clone --recursive https://github.com/pytorch/pytorch "${INSTALL_DIR}/repositories/pytorch"
  fi
  cd "${INSTALL_DIR}/repositories/pytorch"
  git submodule sync
  git submodule update --init --recursive
  source ~/anaconda3/bin/activate
  conda init
  conda update -n base -c defaults conda -y
  conda create -n torch-${CUDA_VERSION} -y
  conda activate torch-${CUDA_VERSION}
  conda install cmake ninja -y
  pip install --upgrade pip
  pip install --upgrade -r requirements.txt
  conda install mkl mkl-include -y
  conda install -c pytorch magma-cuda${CUDA_VERSION} -y
  export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
  python setup.py clean
  python setup.py develop
  # What comes next?
  conda deactivate
else
  # install the matching cuda version of pytorch and torchvision
  progress "Installing PyTorch, TorchVision, and TorchAudio for CUDA ${CUDA_VERSION}..."
  pip install torch torchvision torchaudio --extra-index-url "https://download.pytorch.org/whl/cu${CUDA_VERSION}"
fi

# Install GPTQ support for 4bit 128g LLaMA
progress "Installing GPTQ for LLaMA..."
if [ ! -d "${INSTALL_DIR}/repositories/GPTQ-for-LLaMa" ]; then
  git clone https://github.com/oobabooga/GPTQ-for-LLaMa.git -b cuda "${INSTALL_DIR}/repositories/GPTQ-for-LLaMa"
fi
cd "${INSTALL_DIR}/repositories/GPTQ-for-LLaMa"
pip install torch torchvision --extra-index-url "https://download.pytorch.org/whl/cu${CUDA_VERSION}"
python setup_cuda.py install
cd "${INSTALL_DIR}"

# Install xformers for extra speed and memory efficiency
if [ -z ${XFORMERS_WHL} ]; then
  progress "Building xformers (this can take a really long time)..."
  if [ -d "${INSTALL_DIR}/repositories/xformers" ]; then
    git clone https://github.com/facebookresearch/xformers.git "${INSTALL_DIR}/repositories/xformers"
  fi
  cd "${INSTALL_DIR}/repositories/xformers"
  git pull
  git submodule update --init --recursive
  python -m venv venv
  source venv/bin/activate
  pip install --upgrade pip
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
