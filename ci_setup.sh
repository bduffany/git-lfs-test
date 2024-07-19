#!/usr/bin/env bash
set -euo pipefail

cd "$BUILD_WORKSPACE_DIRECTORY"

if ! command -v git-lfs &>/dev/null; then
  export DEBIAN_FRONTEND=noninteractive
  sudo apt update
  sudo apt install -y git-lfs
fi

git lfs pull

