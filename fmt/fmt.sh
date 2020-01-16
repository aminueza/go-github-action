#!/bin/bash

ACTION_PATH=${GITHUB_WORKSPACE:-.}/$1
ACTION_PATH=${ACTION_PATH%/.}

# Execute fmt tool, resolve and emit each unformatted file
UNFORMATTED_FILES=$(gofmt -l "$ACTION_PATH")

if [ -n "$UNFORMATTED_FILES" ]; then
	echo '::error::The following files are not properly formatted:'
	echo "$UNFORMATTED_FILES" | while read -r LINE; do
		FILE=$(realpath --relative-base="$ACTION_PATH" "$LINE")
		echo "::error::  $FILE"
	done
	exit 1
fi
