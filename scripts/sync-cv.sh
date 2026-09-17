#!/usr/bin/env bash
# CV リポジトリ (../cv) をビルドし、PDF と業績データをこのリポジトリへ取り込む。
#
# 取り込んだ public/cv.pdf と src/data/publications.json は「コミットする」こと。
# CI (GitHub Actions) には ../cv が存在しないため、リポジトリ内に実体が必要。
set -euo pipefail

CV_DIR="${CV_DIR:-$(cd "$(dirname "$0")/../../cv" && pwd)}"
SITE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [[ ! -f "$CV_DIR/cv.typ" ]]; then
  echo "error: CV が見つかりません: $CV_DIR/cv.typ" >&2
  echo "  CV_DIR=/path/to/cv $0 のように指定してください。" >&2
  exit 1
fi

echo "==> typst compile ($CV_DIR)"
(cd "$CV_DIR" && typst compile cv.typ)

echo "==> copy"
cp "$CV_DIR/cv.pdf"           "$SITE_DIR/public/cv.pdf"
cp "$CV_DIR/publications.json" "$SITE_DIR/src/data/publications.json"

echo "✅ 同期しました:"
echo "   public/cv.pdf              ($(du -h "$SITE_DIR/public/cv.pdf" | cut -f1))"
echo "   src/data/publications.json ($(python3 -c "import json;print(len(json.load(open('$SITE_DIR/src/data/publications.json'))['conference']),'papers')"))"
