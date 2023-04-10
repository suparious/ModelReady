#!/usr/bin/env python3

import os
import sys
import subprocess

def print_usage():
  print("Usage: python3 chat.py [model_path] [prompt_path]")
  print("  model_path: Optional. Path to the model file. Defaults to the gpt4-x-alpaca-native-13B-ggml.bin in the 'llama-ggml-tools/models' directory in the user's home.")
  print("  prompt_path: Optional. Path to the prompt file. Defaults to the Alpaca.txt in the 'llama-ggml-tools/prompts' directory in the user's home.")

def download_and_build_llama(llama_path):
  # Clone the llama.cpp repository
  subprocess.run(['git', 'clone', 'https://github.com/ggerganov/llama.cpp.git', llama_path])
  # Build the llama.cpp executable
  subprocess.run(['make'], cwd=llama_path)

def main():
  # Set the model path. Use the provided argument, if available, otherwise use the default model path.
  model = sys.argv[1] if len(sys.argv) > 1 else os.path.join(os.environ['HOME'], 'llama-ggml-tools', 'models', 'gpt4-x-alpaca-native-13B-ggml.bin')
  # Check if the model file exists
  if not os.path.isfile(model):
    print(f"Error: Model file not found at {model}")
    print_usage()
    sys.exit(1)
  # Set the prompt path. Use the provided argument, if available, otherwise use the default prompt path.
  prompt = sys.argv[2] if len(sys.argv) > 1 else os.path.join(os.environ['HOME'], 'llama-ggml-tools', 'prompts', 'Alpaca.txt')
  # Check if the prompt file exists
  if not os.path.isfile(prompt):
    print(f"Error: Prompt file not found at {prompt}")
    print_usage()
    sys.exit(1)
  # Set the path for the llama.cpp repository.
  llama_path = os.path.join(os.environ['HOME'], 'llama-ggml-tools', 'repos', 'llama.cpp')
  llama_executable = os.path.join(llama_path, 'main')
  # Check if the llama.cpp folder exists
  if not os.path.exists(llama_path):
    print("llama.cpp folder not found. Downloading and building the executable...")
    download_and_build_llama(llama_path)

  print(f"Model: {model}")

  # Run the llama.cpp executable with the specified arguments
  subprocess.run([
    llama_executable,
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
