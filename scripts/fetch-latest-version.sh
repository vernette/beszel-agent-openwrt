#!/usr/bin/env bash

set -euo pipefail

REPO="${1:-henrygd/beszel}"
GH_TOKEN="${GH_TOKEN:-}"

if [[ -n "$GH_TOKEN" ]]; then
  AUTH_HEADER="Authorization: token $GH_TOKEN"
else
  AUTH_HEADER=""
fi

TAG=$(wget -qO- ${AUTH_HEADER:+--header="$AUTH_HEADER"} \
  "https://api.github.com/repos/$REPO/releases/latest" |
  grep -Po '"tag_name": "\K[^"]+')

if [[ -z "$TAG" ]]; then
  echo "Failed to fetch latest version" >&2
  exit 1
fi

echo "$TAG"
