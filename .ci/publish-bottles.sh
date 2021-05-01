#!/bin/bash
# $1: package name
set -ue

# Make brew use our checkout
brewpwd=$(brew --repo dciabrin/ngdevkit)
mkdir -p $brewpwd
mv $brewpwd /tmp
ln -s $PWD $brewpwd

branch=$(echo $BRANCH | sed 's%refs/heads/%%')
pkg=$(.ci/pkg-name-from-branch.sh $branch)

keepopt=$(if brew info --json dciabrin/ngdevkit/$pkg | jq '.[0].bottle | length' | grep -wq 1; then echo "--keep-old"; fi)

echo "Upload bottle with: brew pr-upload --no-commit $keepopt --debug"
brew pr-upload --no-commit $keepopt --debug

echo
echo "All bottles for $pkg compiled and published"
