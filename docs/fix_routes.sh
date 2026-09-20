#!/usr/bin/env sh

OUT_DIR="./.vitepress/dist"

if [ ! -d "$OUT_DIR" ]; then
  echo "❌ Error: Directory '$OUT_DIR' does not exist."
  exit 1
fi

echo "🔧 Fixing routes in: $OUT_DIR"

# 1. Fix root-level .html files
find "$OUT_DIR" -maxdepth 1 -type f -name '*.html' | while read -r file; do
  tmpfile="$(mktemp)"
  sed -E 's#(href|src)="/([^/][^"]*)"#\1="./\2"#g' "$file" > "$tmpfile" && mv "$tmpfile" "$file"
  echo "✅ Fixed (root): ${file##*/}"
done

# 2. Fix guide/ .html files
find "$OUT_DIR/guide" -type f -name '*.html' | while read -r file; do
  tmpfile="$(mktemp)"
  sed -E 's#(href|src)="/([^/][^"]*)"#\1="../\2"#g' "$file" > "$tmpfile" && mv "$tmpfile" "$file"
  echo "✅ Fixed (guide): ${file##*/}"
done

echo "✅ All routes updated for offline use."
