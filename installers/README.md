## Installations requirements

These installers are an attempt to use python to avoid operating system specific installation instructions. The goal is to have a single python script that can be run on any system to install the required software.

At the absolute minimum, these scripts are assuming you have installed and configured:

* python3, python3-pip, python3-venv
* python3-is-python

The following are also recommended, but may get installed for you wherever I was unable to avoid using them:
* [pyenv](https://github.com/pyenv/pyenv)
* [anaconda](https://www.anaconda.com/download#downloads) (if custom building torch on cuda)
* [minikube](https://minikube.sigs.k8s.io/docs/start/)    (Milvus vector database and search service)

Check [DEBIAN.md](./DEBIAN.md) for specific step-by-step instruction on preparing a GNU/Debian based NVIDIA system.

## CUDA Support (NVIDIA GPUs)

Check your current cuda version

```bash
nvcc --version | awk -F ',' {' print $2 '} | sed -e 's/ //g' | sed -e 's/\.//g' | sed -e 's/release//g' | uniq
```

Manually installing the matching version of pytorch

```bash
pip install light-the-torch
ltt install --pytorch-computation-backend=cu${CUDA_VERSION} torch torchvision torchaudio
```