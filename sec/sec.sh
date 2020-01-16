#!/bin/bash

ACTION_PATH=${GITHUB_WORKSPACE:-.}/$1
ACTION_CONFIDENCE=$2
ACTION_SEVERITY=$3

BASE_DIR=$(dirname "$ACTION_PATH")

# Execute vet tool, removing comment lines and 'tool: ' prefixes
GOSEC_ARGS=("-quiet" "-fmt=golint")
[ -n "$ACTION_CONFIDENCE" ] && GOSEC_ARGS+=("-confidence=$ACTION_CONFIDENCE")
[ -n "$ACTION_SEVERITY" ] && GOSEC_ARGS+=("-severity=$ACTION_SEVERITY")
ERRORS=$(gosec "${GOSEC_ARGS[@]}" "$ACTION_PATH" 2>&1 | sed -e '/^#/d' | sed -E -e 's/^[[:alpha:]]+: //')

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
