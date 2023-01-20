#!/bin/bash

packages=$(git show --pretty="" --name-only | grep '^Formula/' | sed -e 's%^Formula/%%' -e 's%.rb$%%')

if [ -n "$packages" ]; then
    echo "Cleaning up ngdevkit nightly releases for packages: $packages"
    echo
    for p in $packages; do
        .ci/gc-nightly-releases.sh --package $p
        echo
    done
else
    echo "No Formula was updated in latest commit in current branch"    
fi
