#!/bin/bash
set -euo pipefail

PWD=$(dirname -- "$(readlink -f -- "$0")")
SUBGRAPH_DIR="${1:+/$1}"
IPFS_URL="${IPFS_URL:-http://localhost:5001}"
MANIFEST_TEMPLATE="subgraph.template.yaml"
MANIFEST="subgraph.generated.yaml"

PWD="$PWD$SUBGRAPH_DIR"

cp "$PWD/$MANIFEST_TEMPLATE" "$PWD/$MANIFEST"

for file in "$PWD"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        response=$(curl -s -X POST -F "file=@$file" "$IPFS_URL/api/v0/add")
        cid=$(echo "$response" | jq -r '.Hash')

        sed -i "s/$filename/\/ipfs\/$cid/g" "$PWD/$MANIFEST"
        echo "Uploaded $filename -> $cid"
    fi
done

response=$(curl -s -X POST -F "file=@$PWD/$MANIFEST" "$IPFS_URL/api/v0/add")
cid=$(echo "$response" | jq -r '.Hash')

echo "Subgraph Hash: $cid"
