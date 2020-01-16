#!/bin/bash

ACTION_PATH=${GITHUB_WORKSPACE:-.}/$1

BASE_DIR=$(dirname "$ACTION_PATH")

# Execute golint tool, removing comment lines and 'tool: ' prefixes
ERRORS=$(./bin/golint "$ACTION_PATH" 2>&1)
if [ $? -eq 2 ]; then
	echo '::error::golint tool failed to run'
	echo "$ERRORS"
	exit 2
fi

# Format and emit each error
if [ -n "$ERRORS" ]; then
	echo "$ERRORS" | sed -e '/^#/d' | while read -r LINE; do
		FILE=$(realpath --relative-base="$BASE_DIR" "$(cut -d: -f1 <<< "$LINE")")
		REST=$(cut -d: -f2- <<< "$LINE")

		ERROR=$(printf "%s:%s" "$FILE" "$REST" | sed -E 's/^([^:]+):([[:digit:]]+):([[:digit:]]+):[[:space:]]*(.*)$/file=\1,line=\2,col=\3::Unhandled error [\4]/')
		echo "::error $ERROR"
	done
	exit 1
fi
