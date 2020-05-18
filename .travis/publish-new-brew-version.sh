#!/bin/bash
#$1: package (e.g. ngdevkit-gngeo)
#$2: branch (e.g. nightly-ngdevkit-gngeo-20200119170941)
set -eu
PKG=$1
BRANCH=$2
git checkout master
git merge --squash $BRANCH
BRANCH_FIRST_COMMIT=$(git log master..$BRANCH --format='%H' | tail -1)
git show $BRANCH_FIRST_COMMIT -q --format=%B | git commit -F -
git push

# Log some confirmation info
PKG_VERSION=$(sed -ne 's/.*version.*"\([^"]*\)".*/\1/p' Formula/$PKG.rb | head -1)
echo "New version of $PKG ($PKG_VERSION) is now available in ngdevkit tap"
