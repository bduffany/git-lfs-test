#!/usr/bin/env bash
set -euo pipefail
: "${BIG_FILE_MAX_SIZE:=4000000}"
FILE_SIZE=$(python3 -c "import random; print(random.randint(10_000, $BIG_FILE_MAX_SIZE), end='')")
mkdir -p big
head -c "$FILE_SIZE" </dev/random >big/$(uuidgen).big

