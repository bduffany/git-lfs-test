#!/usr/bin/env bash
set -euo pipefail

cd "$BUILD_WORKSPACE_DIRECTORY"

export DEBIAN_FRONTEND=noninteractive
sudo apt update
sudo apt install -y git-lfs
git lfs pull

