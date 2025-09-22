#!/usr/bin/env bash

set -e

JSON_MODE=false
ARGS=()
for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        --help|-h) echo "Usage: $0 [--json] <project_description>"; exit 0 ;;
        *) ARGS+=("$arg") ;;
    esac
done

MAX_EPICS=5

PROJECT_DESCRIPTION="${ARGS[*]}"
if [ -z "$PROJECT_DESCRIPTION" ]; then
    echo "Usage: $0 [--json] <project_description>" >&2
    exit 1
fi

# Function to find the repository root by searching for existing project markers
find_repo_root() {
    local dir="$1"
    while [ "$dir" != "/" ]; do
        if [ -d "$dir/.git" ] || [ -d "$dir/.specify" ]; then
            echo "$dir"
            return 0
        fi
        dir="$(dirname "$dir")"
    done
    return 1
}

# Resolve repository root. Prefer git information when available, but fall back
# to searching for repository markers so the workflow still functions in repositories that
# were initialised with --no-git.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if git rev-parse --show-toplevel >/dev/null 2>&1; then
    REPO_ROOT=$(git rev-parse --show-toplevel)
    HAS_GIT=true
else
    REPO_ROOT="$(find_repo_root "$SCRIPT_DIR")"
    if [ -z "$REPO_ROOT" ]; then
        echo "Error: Could not determine repository root. Please run this script from within the repository." >&2
        exit 1
    fi
    HAS_GIT=false
fi

cd "$REPO_ROOT"

SPECS_DIR="$REPO_ROOT/specs"
mkdir -p "$SPECS_DIR"

HIGHEST=0
if [ -d "$SPECS_DIR" ]; then
    for dir in "$SPECS_DIR"/*; do
        [ -d "$dir" ] || continue
        dirname=$(basename "$dir")
        number=$(echo "$dirname" | grep -o '^[0-9]\+' || echo "0")
        number=$((10#$number))
        if [ "$number" -gt "$HIGHEST" ]; then HIGHEST=$number; fi
    done
fi

NEXT=$((HIGHEST + 1))
FEATURE_NUM=$(printf "%03d" "$NEXT")

BRANCH_NAME=$(echo "$PROJECT_DESCRIPTION" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
WORDS=$(echo "$BRANCH_NAME" | tr '-' '\n' | grep -v '^$' | head -3 | tr '\n' '-' | sed 's/-$//')
BRANCH_NAME="${FEATURE_NUM}-${WORDS}"

if [ "$HAS_GIT" = true ]; then
    git checkout -b "$BRANCH_NAME"
else
    >&2 echo "[specify] Warning: Git repository not detected; skipped branch creation for $BRANCH_NAME"
fi

PROJECT_DIR="$SPECS_DIR/$BRANCH_NAME"
mkdir -p "$PROJECT_DIR"

TEMPLATE="$REPO_ROOT/templates/epic-template.md"
EPIC_FILE="$PROJECT_DIR/epic.md"
if [ -f "$TEMPLATE" ]; then cp "$TEMPLATE" "$EPIC_FILE"; else touch "$EPIC_FILE"; fi

# Set the SPECIFY_FEATURE environment variable for the current session
export SPECIFY_FEATURE="$BRANCH_NAME"

if $JSON_MODE; then
    printf '{"BRANCH_NAME":"%s","EPIC_FILE":"%s","FEATURE_NUM":"%s","MAX_EPICS":"%s"}\n' "$BRANCH_NAME" "$EPIC_FILE" "$FEATURE_NUM" "$MAX_EPICS"
else
    echo "BRANCH_NAME: $BRANCH_NAME"
    echo "EPIC_FILE: $EPIC_FILE"
    echo "FEATURE_NUM: $FEATURE_NUM"
    echo "MAX_EPICS: $MAX_EPICS"
    echo "SPECIFY_FEATURE environment variable set to: $BRANCH_NAME"
fi
