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

# Temporary workaround for the Tap trust conendrum:
#   - in CI, brew will refuse to consider the ngdevkit tap unless
#     it is trusted.
#   - brew test-bot reconfigures the env so that HOME and all other
#     important variables point to the homebrew-ngdevkit/home/...
#     subdirectory... so the tap trust has to live in there
#   - ... but the first thing test-bot does is to git clean the
#     homebrew-ngdevkit directory, effectively deleting the trust
#     file :/
#   - when test-bot starts, it wants to copy the trust file from
#     $HOME into homebrew-ngdevkit/home to isolate the CI build,
#     however $HOME has been modified to point to homebrew-ngdevkit
#     already, so this makes test-bot setup fail if a trust file
#     exists prior to the run.
# to workaround all that, we first trust the tap, then save the trust
# file in a temporary git commit, and remove the trust file
# prior to running test-bot. the git clean will restore it for us.
echo "Trusting the ngdevkit tap for brew test-bot"
brew trust dciabrin/ngdevkit
mkdir -p $PWD/home/.homebrew
cp $HOME/.homebrew/trust.json $PWD/home/.homebrew
git add $PWD/home/.homebrew/trust.json
git commit -m 'Temporary tap trust (CI)' --author 'CI build bot <>'

# build bottle
echo "Build bottle with: brew test-bot $keepopt --skip-setup --tap=dciabrin/ngdevkit Formula/$pkg.rb --debug"
brew test-bot $keepopt --skip-setup --tap=dciabrin/ngdevkit Formula/$pkg.rb --debug
