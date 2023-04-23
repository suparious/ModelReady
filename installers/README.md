
check DEBIAN.md for instruxtion on preparing a debian based system

check your current cuda version

```bash
nvcc --version | awk -F ',' {' print $2 '} | sed -e 's/ //g' | sed -e 's/\.//g' | sed -e 's/release//g' | uniq
```

Install the matching version of pytorch

```bash
pip install light-the-torch
ltt install --pytorch-computation-backend=cu${CUDA_VERSION} torch torchvision torchaudio
```