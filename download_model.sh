#!/usr/bin/env bash
set -euo pipefail

MODEL_DIR="model"
MODEL_FILE="$MODEL_DIR/qwen2.5-1.5b-instruct-q4_k_m.gguf"
MODEL_URL="https://huggingface.co/Qwen/Qwen2.5-1.5B-Instruct-GGUF/resolve/main/qwen2.5-1.5b-instruct-q4_k_m.gguf"
EXPECTED_SHA256="6a1a2eb6d15622bf3c96857206351ba97e1af16c30d7a74ee38970e434e9407e"

mkdir -p "$MODEL_DIR"

if [ -f "$MODEL_FILE" ]; then
    echo "Model already exists. Verifying..."
else
    echo "Downloading Qwen2.5-1.5B-Instruct Q4_K_M..."
    curl -L --fail --retry 3 --progress-bar \
        "$MODEL_URL" \
        -o "$MODEL_FILE"
fi

ACTUAL_SHA256="$(sha256sum "$MODEL_FILE" | awk '{print $1}')"

if [ "$ACTUAL_SHA256" != "$EXPECTED_SHA256" ]; then
    echo "ERROR: SHA-256 verification failed."
    echo "Expected: $EXPECTED_SHA256"
    echo "Actual:   $ACTUAL_SHA256"
    exit 1
fi

echo "Model verified successfully."
echo "SHA-256: $ACTUAL_SHA256"
echo "Path: $MODEL_FILE"
