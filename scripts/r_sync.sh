#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<EOF
Usage: $(basename "$0") [options] <source> <destination>

Sync destination to match source using rsync.

Options:
  -r          Recursive (for directories)
  -e <ssh>    SSH command (e.g. -e "ssh -p 2222")
  -n          Dry run (show what would be transferred)
  -d          Delete files in destination not in source
  -v          Verbose output
  -h          Show this help message

Examples:
  $(basename "$0") file.txt /backup/file.txt
  $(basename "$0") -r ~/projects /backup/projects
  $(basename "$0") -r -d ~/projects user@host:/backup/projects
  $(basename "$0") -r -e "ssh -p 2222" ~/projects user@host:/backup/
  $(basename "$0") -n -r -d ~/projects /backup/projects
EOF
    exit 0
}

RSYNC_OPTS=(-a --progress)
DRY_RUN=false
RECURSIVE=false
DELETE=false
SSH_CMD=""

while getopts ":re:ndvh" opt; do
    case "$opt" in
        r) RECURSIVE=true ;;
        e) SSH_CMD="$OPTARG" ;;
        n) DRY_RUN=true ;;
        d) DELETE=true ;;
        v) RSYNC_OPTS+=(-v) ;;
        h) usage ;;
        :) echo "Error: -$OPTARG requires an argument"; exit 1 ;;
        *) echo "Unknown option: -$OPTARG"; usage ;;
    esac
done
shift $((OPTIND - 1))

if [ $# -ne 2 ]; then
    echo "Error: source and destination required"
    usage
fi

SRC="$1"
DEST="$2"

if ! $RECURSIVE; then
    RSYNC_OPTS=(--progress)
fi

$DRY_RUN && RSYNC_OPTS+=(--dry-run)
$DELETE && RSYNC_OPTS+=(--delete)
[ -n "$SSH_CMD" ] && RSYNC_OPTS+=(-e "$SSH_CMD")

rsync "${RSYNC_OPTS[@]}" "$SRC" "$DEST"
