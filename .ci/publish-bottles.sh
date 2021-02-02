#!/bin/bash
# $1: package name
set -ue

test -n "HOMEBREW_BINTRAY_USER"
test -n "HOMEBREW_BINTRAY_KEY"

branch=$(echo $BRANCH | sed 's%refs/heads/%%')
pkg=$(.ci/pkg-name-from-branch.sh $branch)
pkgversion=$(sed -ne 's/.*version.*"\([^"]*\)".*/\1/p' Formula/$pkg.rb | head -1)
curl -s -X POST -u $HOMEBREW_BINTRAY_USER:$HOMEBREW_BINTRAY_KEY "https://api.bintray.com/content/dciabrin/bottles-ngdevkit/$pkg/${pkgversion}/publish"
echo
echo "All bottles for $pkg compiled and published"
