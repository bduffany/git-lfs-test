#!/usr/bin/env bash
set -euo pipefail

cd "$BUILD_WORKSPACE_DIRECTORY"

sudo apt update
sudo apt install -y git-lfs
git lfs install || true

