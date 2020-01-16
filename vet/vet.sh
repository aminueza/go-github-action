#!/bin/bash

ACTION_PATH=${GITHUB_WORKSPACE:-.}/$1
ACTION_VETTOOL=$2

BASE_DIR=$(dirname "$ACTION_PATH")

# Prepare the vet args
VET_ARGS=()
if [ -n "$ACTION_VETTOOL" ]; then
	if ! ACTION_VETTOOL=$(command -v "$ACTION_VETTOOL"); then
		echo "vettool ${ACTION_VETTOOL} cannot be found"
		exit 1
	fi

	VET_ARGS+=("-vettool=$ACTION_VETTOOL")
fi

# Execute vet tool, removing comment/go build lines and 'tool: ' prefixes
ERRORS=$(go vet "${VET_ARGS[@]}" "$ACTION_PATH" 2>&1 | sed -e '/^#/d;/^go: /d' | sed -E -e 's/^[[:alpha:]]+: //')

# Format and emit each error
if [ -n "$ERRORS" ]; then
	echo "$ERRORS" | while read -r LINE; do
		FILE=$(realpath --relative-base="$BASE_DIR" "$(cut -d: -f1 <<< "$LINE")")
		REST=$(cut -d: -f2- <<< "$LINE")

		ERROR=$(printf "%s:%s" "$FILE" "$REST" | sed -E 's/^([^:]+):([[:digit:]]+):([[:digit:]]+):[[:space:]]*(.*)$/file=\1,line=\2,col=\3::\4/')
		echo "::error $ERROR"
	done
	exit 1
fi
