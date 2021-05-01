#!/bin/sh
set -eu

test -n "$BRANCH"

# Make brew use our checkout
brewpwd=$(brew --repo dciabrin/ngdevkit)
mkdir -p $brewpwd
mv $brewpwd /tmp
ln -s $PWD $brewpwd

branch=$(echo $BRANCH | sed 's%refs/heads/%%')
pkg=$(.ci/pkg-name-from-branch.sh $branch)
echo "Building bottle for $pkg on macOS $OS (branch $branch)"
test -f Formula/$pkg.rb

# configure build-bot based on whether we already have bottles
# for other OS versions
keepopt=$(if brew info --json dciabrin/ngdevkit/$pkg | jq '.[0].bottle | length' | grep -wq 1; then echo "--keep-old"; fi)

# build bottle and upload it to github
rooturl=https://dl.bintray.com/dciabrin/bottles-ngdevkit
cp Formula/$pkg.rb Formula/$pkg.rb.tmp

echo "Build bottle with: brew test-bot $keepopt --skip-setup --tap=dciabrin/ngdevkit Formula/$pkg.rb --debug"
brew test-bot $keepopt --skip-setup --tap=dciabrin/ngdevkit Formula/$pkg.rb --debug
cp Formula/$pkg.rb.tmp Formula/$pkg.rb

git diff | tee git-bottle-sha.diff
