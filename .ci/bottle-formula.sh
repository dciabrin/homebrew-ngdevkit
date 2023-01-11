#!/bin/sh
set -eu

test -n "$BRANCH"

# the BRANCH info coming from Azure looks like 'refs/heads/nightly/pkg'
pkg=$(.ci/pkg-name-from-branch.sh $BRANCH)
echo "Building bottle for $pkg on macOS $OS"
test -f Formula/$pkg.rb

# configure build-bot based on whether we already have bottles
# for other OS versions
keepopt=$(if brew info --json dciabrin/ngdevkit/$pkg | jq '.[0].bottle | length' | grep -wq 1; then echo "--keep-old"; fi)

# build bottle
echo "Build bottle with: brew test-bot $keepopt --skip-setup --tap=dciabrin/ngdevkit Formula/$pkg.rb --debug"
brew test-bot $keepopt --skip-setup --tap=dciabrin/ngdevkit Formula/$pkg.rb --debug
