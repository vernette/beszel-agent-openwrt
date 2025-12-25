#!/usr/bin/env bash

set -euo pipefail

VERSION="$1"
GOARCH="$2"
OUTPUT_DIR="$3"

VERSION="${VERSION#v}"

OUTPUT_DIR=$(realpath -m "$OUTPUT_DIR")

BINARY_URL="https://github.com/henrygd/beszel/releases/download/v${VERSION}/beszel-agent_linux_${GOARCH}.tar.gz"

echo "Downloading from: $BINARY_URL"

WORK_DIR=$(mktemp -d)
trap 'rm -rf "$WORK_DIR"' EXIT
cd "$WORK_DIR"

wget -q --timeout=30 --tries=3 "$BINARY_URL" -O binary.tar.gz || {
  echo "ERROR: Failed to download binary from $BINARY_URL" >&2
  exit 1
}

if [[ ! -s binary.tar.gz ]]; then
  echo "ERROR: Downloaded file is empty" >&2
  exit 1
fi

tar -xzf binary.tar.gz beszel-agent || {
  echo "ERROR: Failed to extract binary" >&2
  exit 1
}

chmod +x beszel-agent

if command -v upx >/dev/null 2>&1; then
  echo "Compressing binary with UPX..."
  upx --best --lzma beszel-agent || {
    echo "WARNING: UPX compression failed, continuing with uncompressed binary" >&2
  }
else
  echo "WARNING: UPX not found, skipping compression" >&2
fi

mkdir -p "$OUTPUT_DIR"
mv beszel-agent "$OUTPUT_DIR/"

echo "Binary prepared successfully at $OUTPUT_DIR/beszel-agent"
