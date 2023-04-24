# Data Science Toolkit Installation Guide

This README provides detailed instructions on how to install the launchers and systemd services for the Data Science Toolkit. The goal is to use a single Python script for installation, minimizing the need for operating system-specific instructions.

## Installation Requirements

At a minimum, ensure you have installed and configured the following prerequisites on your system:

* python3, python3-pip, python3-venv
* python3-is-python

We also recommend installing the following tools, as they may be required for some functionalities:

* [pyenv](https://github.com/pyenv/pyenv)
* [anaconda](https://www.anaconda.com/download#downloads) (for custom building torch with CUDA support)
* [minikube](https://minikube.sigs.k8s.io/docs/start/) (for Milvus vector database and search service)

For step-by-step instructions on preparing a GNU/Debian-based NVIDIA system, refer to [DEBIAN.md](./DEBIAN.md).

## NVIDIA GPU CUDA Support

If your system has an NVIDIA GPU, follow these steps to enable CUDA support:

1. Check your current CUDA version:

   ```bash
   nvcc --version | awk -F ',' {' print $2 '} | sed -e 's/ //g' | sed -e 's/\.//g' | sed -e 's/release//g' | uniq
   ```

2. Install the matching version of PyTorch with CUDA support:

   ```bash
   pip install light-the-torch
   ltt install --pytorch-computation-backend=cu${CUDA_VERSION} torch torchvision torchaudio
   ```

After completing the installation requirements and enabling CUDA support (if applicable), proceed with the installation of the launcher scripts and systemd services as described in the [Launcher Scripts README](../launchers/README.md) and [Systemd Service README](../systemd/README.md).