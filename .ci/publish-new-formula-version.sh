#!/bin/sh
set -eux

test -n "$BRANCH"

# the BRANCH info coming from Azure looks like 'refs/heads/nightly/pkg'
pkg=$(.ci/pkg-name-from-branch.sh $BRANCH)
test -f Formula/$pkg.rb
echo "Publishing new bottle for $pkg"

# Add the bottle information into a new commit
git add Formula/$pkg.rb
previous_subj=$(git log --pretty=format:%s HEAD~..HEAD)
git commit --no-edit -m "${previous_subj} (bottled)"

# merge from the detached branch to master
git format-patch -2 -o new-version
git checkout master
git am new-version/*
git push
