#!/bin/bash

# If unset, set the environment variables with default values
INSTALL_DIR="${INSTALL_DIR:-${HOME}/ooba}"
THREADS="${THREADS:-4}"
PARAMS="${PARAMS:---auto-devices --listen --chat}"
CUDA_HOME="${CUDA_HOME:-/usr/local/cuda-11.7}"

# run the application if it is installed
if [ -d "${INSTALL_DIR}" ]; then
  cd "${INSTALL_DIR}"
  if [ -f "server.py" ]; then
    # update the repository
    git pull
    # activate the virtual environment
    source venv/bin/activate
    # install the requirements
    pip install --upgrade pip
    pip install --upgrade -r requirements.txt
    # run the application
    exec python server.py ${PARAMS} --threads ${THREADS}
    deactivate
  else
    echo "ERROR: Oobabooga server.py not found in ${INSTALL_DIR}"
    exit 1
  fi
else
  echo "WARNING: ${INSTALL_DIR} not found"
  exit 1
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