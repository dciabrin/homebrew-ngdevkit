#!/bin/sh
set -eu

test -n "$BRANCH"

branch=$(echo $BRANCH | sed 's%refs/heads/%%')
pkg=$(.ci/pkg-name-from-branch.sh $branch)
echo "Publishing new bottle for $pkg (branch $branch)"
test -f Formula/$pkg.rb

# commit the potential changes to the formula
git add Formula/$pkg.rb
git commit --amend --no-edit

# merge from the detached branch to master
git format-patch -1 -o new-version
git checkout master
git am new-version/*
git push
