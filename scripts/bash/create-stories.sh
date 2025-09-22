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

MAX_STORIES=7
EPIC_TICKET="BA-1"

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

# Creating specs dir for the epic if doesn't exist
EPIC_SPECS_DIR="$SPECS_DIR/$EPIC_TICKET"
mkdir -p "$EPIC_SPECS_DIR"

BRANCH_NAME="main"
TEMPLATE="$REPO_ROOT/templates/stories-template.md"
STORIES_FILE="$EPIC_SPECS_DIR/stories.md"
if [ -f "$TEMPLATE" ]; then cp "$TEMPLATE" "$STORIES_FILE"; else touch "$STORIES_FILE"; fi

# Set the SPECIFY_FEATURE environment variable for the current session
export SPECIFY_FEATURE="$BRANCH_NAME"

if $JSON_MODE; then
    printf '{"BRANCH_NAME":"%s","STORIES_FILE":"%s","EPIC_TICKET":"%s","MAX_STORIES":"%s"}\n' "$BRANCH_NAME" "$STORIES_FILE" "$EPIC_TICKET" "$MAX_STORIES"
else
    echo "BRANCH_NAME: $BRANCH_NAME"
    echo "STORIES_FILE: $STORIES_FILE"
    echo "EPIC_TICKET: $EPIC_TICKET"
    echo "MAX_STORIES: $MAX_STORIES"
    echo "SPECIFY_FEATURE environment variable set to: $BRANCH_NAME"
fi
