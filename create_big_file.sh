#!/usr/bin/env bash
set -euo pipefail
: "${MAX_FILE_SIZE:=4000000}"
FILE_SIZE=$(python3 -c "import random; print(random.randint(1, $MAX_FILE_SIZE), end='')")
mkdir -p big
head -c "$FILE_SIZE" </dev/random >big/$(uuidgen).big

