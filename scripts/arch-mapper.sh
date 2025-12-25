#!/usr/bin/env bash

set -euo pipefail

case "$1" in
  aarch64_*) echo "arm64" ;;
  arm_*) echo "arm" ;;
  mipsel_*) echo "mipsle" ;;
  mips_*) echo "mips" ;;
  x86_64) echo "amd64" ;;
  *)
    echo "Unknown architecture: $1" >&2
    exit 1
    ;;
esac
