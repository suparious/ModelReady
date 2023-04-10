#!/bin/bash
MODEL=$1
LLAMA=${HOME}/repos/llama.cpp
PROMPT=${HOME}/repos/llama-ggml-tools/prompts

if [ "${MODEL}" = "" ];
then
  MODEL=${HOME}/models/gpt4-x-alpaca-native-13B-ggml.bin
fi

echo "Model: ${MODEL}"

${LLAMA}/main -m ${MODEL} --color -f ${PROMPT}/Alpaca.txt -ins -b 256 --top_k 10000 --temp 0.2 --repeat_penalty 1 -t 7

# ./main -m /home/shaun/repos/text-generation-webui/models/gpt4-x-alpaca/ggml-model-q4_1.bin --color -ins -b 256 --top_k 10000 --temp 0.2 --repeat_penalty 1 -t 7