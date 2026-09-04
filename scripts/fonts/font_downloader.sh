#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  font-download.sh [--zip] <url>

Options:
  --zip    Treat the URL as a ZIP file and extract only font files

Examples:
  font-download.sh https://example.com/MyFont.ttf
  font-download.sh --zip https://example.com/fonts.zip
EOF
}

is_font_file() {
  local file="$1"
  case "${file,,}" in
    *.ttf|*.otf|*.ttc|*.woff|*.woff2)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

install_font_files() {
  local src_dir="$1"
  local fonts_dir="${HOME}/.local/share/fonts"

  mkdir -p "$fonts_dir"

  find "$src_dir" -type f | while IFS= read -r file; do
    if is_font_file "$file"; then
      cp -f "$file" "$fonts_dir/"
      echo "Installed: $(basename "$file")"
    fi
  done

  fc-cache -f -v >/dev/null
  echo "Font cache refreshed."
}

download_file() {
  local url="$1"
  local output="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -L --fail -o "$output" "$url"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "$output" "$url"
  else
    echo "Error: neither curl nor wget is installed." >&2
    exit 1
  fi
}

main() {
  local is_zip=0
  local url=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --zip)
        is_zip=1
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        url="$1"
        shift
        ;;
    esac
  done

  if [[ -z "$url" ]]; then
    usage
    exit 1
  fi

  local filename
  filename="$(basename "${url%%\?*}")"
  local download_path="./$filename"

  echo "Downloading: $url"
  download_file "$url" "$download_path"
  echo "Saved to: $download_path"

  if [[ "$is_zip" -eq 1 ]]; then
    if ! command -v unzip >/dev/null 2>&1; then
      echo "Error: unzip is required for --zip mode." >&2
      exit 1
    fi

    local tmpdir
    tmpdir="$(mktemp -d)"

    unzip -q "$download_path" -d "$tmpdir"
    install_font_files "$tmpdir"

    rm -rf "$tmpdir"
  else
    local fonts_dir="${HOME}/.local/share/fonts"
    mkdir -p "$fonts_dir"

    if is_font_file "$download_path"; then
      cp -f "$download_path" "$fonts_dir/"
      echo "Installed: $filename"
      fc-cache -f -v >/dev/null
      echo "Font cache refreshed."
    else
      echo "Error: file does not look like a font. Use --zip for archives." >&2
      exit 1
    fi
  fi
}

main "$@"
