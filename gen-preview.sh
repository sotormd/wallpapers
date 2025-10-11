#! /usr/bin/env bash


set -euo pipefail
IFS=$'\n'  # read line by line safely

WALL_DIR="./wallpapers"

echo "# Preview"
echo

# pind all png files recursively, sort them
mapfile -t files < <(find "$WALL_DIR" -type f -name '*.png' | sort)

for file in "${files[@]}"; do
    # remove leading ./ and WALL_DIR/
    relpath="${file#./}"
    relpath="${relpath#$WALL_DIR/}"

    # convert path to nix attribute format: replace / with .
    attr="${relpath%.*}"
    attr="${attr//\//.}"

    # output markdown block
    printf '`%s`\n' "$attr"
    printf '![](%s)\n\n' "$file"
done
