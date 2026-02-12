#!/bin/bash
set -e
echo "🚀 Starting Kimi K2.5 4-bit Server..."

# Initialize CUDA
nvidia-smi

export LLAMA_SET_ROWS=1

if [ ! -f "/Kimi-K2.5-GGUF/UD-Q4_K_XL/Kimi-K2.5-UD-Q4_K_XL-00001-of-00013.gguf" ]; then
    echo "❌ Model not found!"
    exit 1
fi

if [ ! -f "llama.cpp/build/bin/llama-server" ]; then
    echo "❌ llama-server not built!"
    exit 1
fi

echo "✅ Starting 4-bit server on port 8080..."

cd llama.cpp/build/bin

./llama-server \
  --model /Kimi-K2.5-GGUF/UD-Q4_K_XL/Kimi-K2.5-UD-Q4_K_XL-00001-of-00013.gguf \
  --host 0.0.0.0 \
  --port 8080 \
  --ctx-size 16384 \
  --temp 1.0 \
  --min-p 0.01 \
  --top-p 0.95 \
  --n-gpu-layers 99 \
  --threads 32 \
  --parallel 8 \
  --flash-attn on \
  --verbose

echo "✅ Server running!"
