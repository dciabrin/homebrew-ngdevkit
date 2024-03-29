#!/bin/bash
set -ue

test -n "$BRANCH"

# the BRANCH info coming from Azure looks like 'refs/heads/nightly/pkg'
pkg=$(.ci/pkg-name-from-branch.sh $BRANCH)
echo "Publishing bottle for $pkg"
test -f Formula/$pkg.rb

keepopt=$(if brew info --json dciabrin/ngdevkit/$pkg | jq '.[0].bottle | length' | grep -wq 1; then echo "--keep-old"; fi)

# upload bottles to github
echo "Upload bottle with: brew pr-upload --no-commit $keepopt --debug"
brew pr-upload --no-commit $keepopt --debug

echo
echo "All bottles for $pkg compiled and published"
