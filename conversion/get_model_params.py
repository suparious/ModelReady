from transformers import AutoConfig

model_path = "BioGPT-Large-PubMedQA"

config = AutoConfig.from_pretrained(model_path)

print("Number of layers:", config.num_hidden_layers)
print("Number of heads:", config.num_attention_heads)
print("Model dimension:", config.hidden_size)
