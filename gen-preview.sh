#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n'

WALL_DIR="./wallpapers"

echo "# Preview"
echo

# first: png files in wallpapers/oc
mapfile -t oc_files < <(find "$WALL_DIR/oc" -type f -name '*.png' | sort)

# then: png files in wallpapers/nord
mapfile -t nord_files < <(find "$WALL_DIR/nord" -type f -name '*.png' | sort)

# then: png files in other directories
mapfile -t other_files < <(find "$WALL_DIR" -type f -name '*.png' \
    ! -path "$WALL_DIR/oc/*" \
    ! -path "$WALL_DIR/nord/*" | sort)

# combine all arrays
files=("${oc_files[@]}" "${nord_files[@]}" "${other_files[@]}")

for file in "${files[@]}"; do
    relpath="${file#./}"
    relpath="${relpath#$WALL_DIR/}"

    attr="${relpath%.*}"
    attr="${attr//\//.}"

    printf '`%s`\n' "$attr"
    printf '![](%s)\n\n' "$file"
done
