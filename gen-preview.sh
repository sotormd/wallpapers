#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n'

WALL_DIR="./wallpapers"

echo "# Preview"
echo

mapfile -t other_files < <(find "$WALL_DIR" -type f -name '*.png' | sort)

files=("${other_files[@]}")

for file in "${files[@]}"; do
    relpath="${file#./}"
    relpath="${relpath#$WALL_DIR/}"

    attr="${relpath%.*}"
    attr="${attr//\//.}"

    printf '`%s`\n' "$attr"
    printf '![](%s)\n\n' "$file"
done
