# llama-ggml-tools
Collection of tools for converting and running LLMs with llama.cpp

To use the project default locations, simply run the `chat.py` script. This will install the following:

* https://github.com/ggerganov/llama.cpp

```tree
.
├── chat.py
├── conversion
│   ├── convert-hf-to-pth-16b.py
│   └── convert-pth-to-ggml.py
├── dataset_validator.py
├── get_model_params.py
├── LICENSE
├── models
│   └── gpt4-x-alpaca-native-13B-ggml.bin
├── prompts
│   ├── alpaca-7B.txt
│   ├── Alpaca.txt
│   ├── generic_prompt.png
│   ├── GPT-4chan.txt
│   ├── Open Assistant.txt
│   └── QA.txt
├── README.md
├── repos
│   └── llama.cpp
└── training
    └── full-training-instructions.txt
```

Manual execution example:

```bash
./repos/llama.cpp/main -m models/alpaca-7b-native-enhanced.bin -n -1 --ctx_size 2048 --batch_size 16 --keep 512 --repeat_penalty 1.0 -t 4 --temp 0.4 --top_k 30 --top_p 0.18 --interactive-first -ins --color -i -r "User:" -f prompts/alpacanativeenhanced.txt
```

MacBook Admin

```bash
brew install gh
gh repo list myorgname --limit 1000 | while read -r repo _; do
  gh repo clone "$repo" "$repo"
done
```
