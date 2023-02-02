#!/bin/sh
set -eu

test -n "$BRANCH"

# the BRANCH info coming from Azure looks like 'refs/heads/nightly/pkg'
pkg=$(.ci/pkg-name-from-branch.sh $BRANCH)
test -f Formula/$pkg.rb
echo "Publishing new bottle for $pkg"

# Add the bottle information into a new commit
git add Formula/$pkg.rb
previous_subj=$(git log --pretty=format:%s HEAD~..HEAD)
git commit --no-edit -m "${previous_subj} (bottled)"

# Save the new commit before merging it to master
git format-patch -1 -o new-version

# Ensure that CI has fetched all the refs we need
git fetch --all

# Merge the original commit as a fast forward to avoid diverging
git checkout master
git merge origin/nightly/$pkg --ff-only

# Apply the new commit on top
git am new-version/*
git push

echo
echo "New formula version for $pkg published"
