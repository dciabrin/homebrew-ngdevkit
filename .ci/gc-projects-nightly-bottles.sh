#!/bin/bash

repos=$(git show --pretty="" --name-only | grep '^Formula/' | sed -e 's%^Formula/%%' -e 's%.rb$%%')

if [ -n "$repos" ]; then
    echo "Cleaning up ngdevkit nightly releases"
    echo
    for r in $repos; do
        .ci/gc-nightly-releases.sh --repo $r
        echo
    done
fi
