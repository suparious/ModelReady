#!/bin/bash
# This script is used to launch the Ooba application

# Set the environment variables
INSTALL_DIR="${HOME}/ooba"
PYENV_VERSION="3.11.3"
PARAMS="--auto-devices --listen --threads 4 --chat --xformers"
CUDA_HOME="/usr/local/cuda-11.7"

# run the application if it is installed
if [ -d "${INSTALL_DIR}" ]; then
  cd "${INSTALL_DIR}"
  if [ -f "server.py" ]; then
    # activate the virtual environment
    pyenv shell "${PYENV_VERSION}"
    source venv/bin/activate
    # run the application
    python server.py ${PARAMS}
    deactivate
  else
    echo "ERROR: server.py not found in ${INSTALL_DIR}"
  fi
else
  echo "WARNING: ${INSTALL_DIR} not found"
fi

# params: [-h] [--notebook] [--chat] [--cai-chat] [--model MODEL] [--lora LORA] [--model-dir MODEL_DIR]
#         [--lora-dir LORA_DIR] [--model-menu] [--no-stream] [--settings SETTINGS]
#         [--extensions EXTENSIONS [EXTENSIONS ...]] [--verbose] [--cpu] [--auto-devices]
#         [--gpu-memory GPU_MEMORY [GPU_MEMORY ...]] [--cpu-memory CPU_MEMORY] [--disk]
#         [--disk-cache-dir DISK_CACHE_DIR] [--load-in-8bit] [--bf16] [--no-cache] [--xformers]
#         [--sdp-attention] [--trust-remote-code] [--threads THREADS] [--wbits WBITS] [--model_type MODEL_TYPE]
#         [--groupsize GROUPSIZE] [--pre_layer PRE_LAYER] [--monkey-patch] [--no-quant_attn]
#         [--no-warmup_autotune] [--no-fused_mlp] [--flexgen] [--percent PERCENT [PERCENT ...]]
#         [--compress-weight] [--pin-weight [PIN_WEIGHT]] [--deepspeed] [--nvme-offload-dir NVME_OFFLOAD_DIR]
#         [--local_rank LOCAL_RANK] [--rwkv-strategy RWKV_STRATEGY] [--rwkv-cuda-on] [--listen]
#         [--listen-host LISTEN_HOST] [--listen-port LISTEN_PORT] [--share] [--auto-launch]
#         [--gradio-auth-path GRADIO_AUTH_PATH]