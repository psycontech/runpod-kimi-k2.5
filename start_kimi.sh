#!/bin/bash
set -e

echo "🚀 Starting Kimi K2.5 Server..."

# Set environment variables
export LLAMA_SET_ROWS=1

# Check if model exists
if [ ! -f "/Kimi-K2.5-GGUF/UD-Q2_K_XL/Kimi-K2.5-UD-Q2_K_XL-00001-of-00008.gguf" ]; then
    echo "❌ Model not found! Please download first."
    exit 1
fi

# Check if llama-server exists
if [ ! -f "llama.cpp/build/bin/llama-server" ]; then
    echo "❌ llama-server not built! Please build first."
    exit 1
fi

echo "✅ Starting server on port 8080..."

cd llama.cpp/build/bin

./llama-server \
  --model /Kimi-K2.5-GGUF/UD-Q4_K_XL/Kimi-K2.5-UD-Q4_K_XL-00001-of-00005.gguf \
  --host 0.0.0.0 \
  --port 8080 \
  --ctx-size 16384 \
  --temp 1.0 \
  --min-p 0.01 \
  --top-p 0.95 \
  --n-gpu-layers 99 \
  --threads 12 \
  --parallel 4 \
  -ot ".ffn_.*_exps.=CPU"

