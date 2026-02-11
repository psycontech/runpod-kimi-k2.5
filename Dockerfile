FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    curl \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install huggingface_hub
RUN pip3 install --no-cache-dir huggingface_hub

# Set working directory
WORKDIR /app

# Copy model files (you'll need to do this manually or via volume mount)
COPY Kimi-K2.5-GGUF Kimi-K2.5-GGUF

# Clone and build llama.cpp
RUN git clone https://github.com/ggerganov/llama.cpp && \
    cd llama.cpp && \
    mkdir build && \
    cd build && \
    cmake .. -DGGML_CUDA=ON && \
    cmake --build . --config Release -j$(nproc)

# Copy startup script
COPY start_kimi.sh start_kimi.sh
RUN chmod +x /app/start_kimi.sh

# Expose port
EXPOSE 8080

# Set environment variables
ENV LLAMA_SET_ROWS=1

# Start server
CMD ["start_kimi.sh"]
