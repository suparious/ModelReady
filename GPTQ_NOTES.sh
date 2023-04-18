#convert LLaMA to hf
python convert_llama_weights_to_hf.py --input_dir /path/to/downloaded/llama/weights --model_size 7B --output_dir ./llama-hf

# Benchmark language generation with 4-bit LLaMA-7B:

# Save compressed model
CUDA_VISIBLE_DEVICES=0 python llama.py ./llama-hf/llama-7b c4 --wbits 4 --true-sequential --act-order --groupsize 128 --save llama7b-4bit-128g.pt
# Or save compressed `.safetensors` model
CUDA_VISIBLE_DEVICES=0 python llama.py ./llama-hf/llama-7b c4 --wbits 4 --true-sequential --act-order --groupsize 128 --save_safetensors llama7b-4bit-128g.safetensors

# Benchmark generating a 2048 token sequence with the saved model
CUDA_VISIBLE_DEVICES=0 python llama.py ./llama-hf/llama-7b c4 --wbits 4 --groupsize 128 --load llama7b-4bit-128g.pt --benchmark 2048 --check
# Benchmark FP16 baseline, note that the model will be split across all listed GPUs
CUDA_VISIBLE_DEVICES=0,1,2,3,4 python llama.py ./llama-hf/llama-7b c4 --benchmark 2048 --check

# model inference with the saved model
CUDA_VISIBLE_DEVICES=0 python llama_inference.py ./llama-hf/llama-7b --wbits 4 --groupsize 128 --load llama7b-4bit-128g.pt --text "this is llama"
# model inference with the saved model using safetensors loaded direct to gpu
CUDA_VISIBLE_DEVICES=0 python llama_inference.py ./llama-hf/llama-7b --wbits 4 --groupsize 128 --load llama7b-4bit-128g.safetensors --text "this is llama" --device=0
# model inference with the saved model with offload(This is very slow. This is a simple implementation and could be improved with technologies like flexgen(https://github.com/FMInference/FlexGen).
CUDA_VISIBLE_DEVICES=0 python llama_inference_offload.py ./llama-hf/llama-7b --wbits 4 --groupsize 128 --load llama7b-4bit-128g.pt --text "this is llama" --pre_layer 16
It takes about 180 seconds to generate 45 tokens(5->50 tokens) on single RTX3090 based on LLaMa-65B. pre_layer is set to 50.