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