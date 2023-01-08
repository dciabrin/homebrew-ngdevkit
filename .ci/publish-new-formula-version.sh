#!/bin/sh
set -eu

test -n "$BRANCH"

# the BRANCH info coming from Azure looks like 'refs/heads/nightly/pkg'
pkg=$(.ci/pkg-name-from-branch.sh $BRANCH)
test -f Formula/$pkg.rb
echo "Publishing new bottle for $pkg"

# commit the potential changes to the formula
git add Formula/$pkg.rb
git commit --amend --no-edit

# merge from the detached branch to master
git format-patch -1 -o new-version
git checkout master
git am new-version/*
git push
