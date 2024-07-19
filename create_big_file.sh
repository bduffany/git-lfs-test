#!/usr/bin/env bash
set -euo pipefail
FILE_SIZE=$(python3 -c 'import random; print(random.randint(10_000, 4_000_000), end="")')
mkdir -p big
head -c "$FILE_SIZE" </dev/random >big/$(uuidgen).big

