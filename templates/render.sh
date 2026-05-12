#!/usr/bin/env bash
# ============================================================
# Canonical Porter's Five Forces PDF renderer.
# Usage: bash render.sh <input.html> <output.pdf>
# ============================================================
set -euo pipefail

INPUT_HTML="${1:-}"
OUTPUT_PDF="${2:-}"

if [[ -z "$INPUT_HTML" || -z "$OUTPUT_PDF" ]]; then
  echo "Usage: bash render.sh <input.html> <output.pdf>" >&2
  exit 1
fi

if [[ ! -f "$INPUT_HTML" ]]; then
  echo "Input HTML not found: $INPUT_HTML" >&2
  exit 1
fi

INPUT_ABS="$(cd "$(dirname "$INPUT_HTML")" && pwd)/$(basename "$INPUT_HTML")"
OUTPUT_ABS="$(cd "$(dirname "$OUTPUT_PDF")" && pwd)/$(basename "$OUTPUT_PDF")"

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
if [[ ! -x "$CHROME" ]]; then
  echo "Google Chrome not found at $CHROME" >&2
  exit 1
fi

"$CHROME" \
  --headless \
  --disable-gpu \
  --no-pdf-header-footer \
  --print-to-pdf-no-header \
  --print-to-pdf="$OUTPUT_ABS" \
  "file://$INPUT_ABS" 2>&1 | grep -v -E "gcm|os_integration|allocator" || true

echo "Rendered: $OUTPUT_ABS"
