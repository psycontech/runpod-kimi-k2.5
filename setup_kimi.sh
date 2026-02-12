#!/bin/bash
set -e

echo "=========================================="
echo "Kimi K2.5 Setup Script"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "⚠️  Please run as root (sudo)"
    exit 1
fi

# Step 1: Install dependencies
echo "📦 Installing dependencies..."
apt-get update
apt-get install -y build-essential cmake git wget curl python3 python3-pip

# Step 2: Install huggingface_hub
echo "🔧 Installing Hugging Face Hub..."
pip3 install --upgrade huggingface_hub

# Step 3: Download model
echo "🔽 Downloading Kimi K2.5 model..."
echo ""
echo ""

python3 << 'PYTHON_EOF'
from huggingface_hub import snapshot_download
import os
print("Downloading model...")
snapshot_download(
    repo_id="unsloth/Kimi-K2.5-GGUF",
    allow_patterns=["*UD-Q4_K_XL*"],
    local_dir="/Kimi-K2.5-GGUF",
)
print("✅ Download complete!")
PYTHON_EOF

# Step 4: Build llama.cpp
echo "🔨 Building llama.cpp..."

if [ ! -d "llama.cpp" ]; then
    git clone https://github.com/ggerganov/llama.cpp
fi

cd llama.cpp
mkdir -p build
cd build
cmake .. -DGGML_CUDA=ON
cmake --build . --config Release -j$(nproc)

echo ""
echo "=========================================="
echo "✅ Setup Complete!"
echo "=========================================="
echo ""
echo "To start the server, run:"
echo "  ./start_kimi.sh"
echo ""
echo "Or use Docker:"
echo "  docker-compose up -d"
echo ""

