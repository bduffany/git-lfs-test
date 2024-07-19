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
REQUEST='{
  "repo_url": "'"$(git remote get-url origin)"'",
  "branch": "'"$(git branch --show-current)"'",
  "commit_sha": "'"$(git rev-parse HEAD)"'",
  "action_names": ["Test"],
  "env": {
    "GIT_TRACE": "1",
    "GIT_CURL_VERBOSE": "1",
    "GIT_TRANSFER_TRACE": "1"
  }
}'
echo 'ExecuteWorkflow' "$REQUEST"
RESPONSE=$(
  curl --fail-with-body -sL \
  -H "x-buildbuddy-api-key: $API_KEY" \
  -H 'Content-Type: application/json' \
  "$API_URL/api/v1/ExecuteWorkflow" \
  --data "$REQUEST" | tee /dev/stderr && echo >&2
)
IID=$(echo "$RESPONSE" | jq -r '.actionStatuses[].invocationId')
open "$API_URL/invocation/$IID"

