#!/bin/bash

# $1: OS version (e.g. 10.14)

LATEST_COMMIT_MSG=$(git log --format=%B -n 1)

if echo "$LATEST_COMMIT_MSG" | grep -q -w 'bottled:'; then
    NEW_COMMIT="$LATEST_COMMIT_MSG, $1"
else
    NEW_COMMIT="$LATEST_COMMIT_MSG - bottled: $1"
fi

echo $NEW_COMMIT
