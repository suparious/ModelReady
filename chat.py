#!/usr/bin/env python3

import os
import sys
import subprocess

def main():
  # Set the model path. Use the provided argument, if available, otherwise use the default model path.
  model = sys.argv[1] if len(sys.argv) > 1 else os.path.join(os.environ['HOME'], 'models', 'gpt4-x-alpaca-native-13B-ggml.bin')
  prompt = sys.argv[2] if len(sys.argv) > 1 else os.path.join(os.environ['HOME'], 'llama-ggml-tools', 'prompts', 'Alpaca.txt')
  llama = os.path.join(os.environ['HOME'], 'llama-ggml-tools', 'repos', 'llama.cpp')
  # if missing the llama.cpp folder, download it from https://github.com/ggerganov/llama.cpp
  # run `make` in the llama.cpp folder to build the executable

  print(f"Model: {model}")

  subprocess.run([
    os.path.join(llama, 'main'),
    '-m', model,
    '--color',
    '-f', os.path.join(prompt),
    '-ins',
    '-b', '256',
    '--top_k', '10000',
    '--temp', '0.2',
    '--repeat_penalty', '1',
    '-t', '7'
  ])

if __name__ == '__main__':
  main()
