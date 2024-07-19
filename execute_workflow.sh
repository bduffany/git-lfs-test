#!/usr/bin/env bash
set -euo pipefail

: "${API_KEY?}"
: "${API_URL:=http://localhost:8080}"

cd "$(dirname "$(readlink "$0")")"

./create_big_file.sh
git add big/
git commit -m "Add another big file"
git lfs push --all origin
git push
echo 'Calling ExecuteWorkflow...'
IID=$(
  curl -fsSL \
  -H "x-buildbuddy-api-key: $API_KEY" \
  -H 'Content-Type: application/json' \
  "$API_URL/api/v1/ExecuteWorkflow" \
  --data '{
    "repo_url": "'"$(git remote get-url origin)"'",
    "branch": "'"$(git branch --show-current)"'",
    "commit_sha": "'"$(git rev-parse HEAD)"'"
  }' | \
  jq -r '.actionStatuses[].invocationId'
)
open "$API_URL/invocation/$IID"

