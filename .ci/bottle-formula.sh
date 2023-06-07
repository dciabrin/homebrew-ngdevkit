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

# workaround for https://github.com/Homebrew/homebrew-test-bot/commit/0de9223c4068c45062d3e9035af1f8f931f4aa1b
# that breaks our way of building bottles incrementally and passing bottles
# between several calls to `brew test-bot`.
formulae=/usr/local/Homebrew/Library/Taps/homebrew/homebrew-test-bot/lib/tests/formulae.rb
echo "Temporary workaround in $formulae"
brew test-bot --help &>/dev/null
awk '/def run!/ {def=1; print; next} def==1 {def=0; next} {print}' $formulae | awk '/def verify_local_bottles/ {print $0"\n        puts \"TRACE #{@bottle_checksums}\""; next} {print}' | awk '/def bottle_reinstall_formula/ {drop=1} drop==1 && /        verify_local_bottles/ {drop=0;next} {print}' > /tmp/formulae.rb
cp /tmp/formulae.rb $formulae
grep -A1 'def run!' $formulae

# build bottle
echo "Build bottle with: brew test-bot $keepopt --skip-setup --tap=dciabrin/ngdevkit Formula/$pkg.rb --debug"
brew test-bot $keepopt --skip-setup --tap=dciabrin/ngdevkit Formula/$pkg.rb --debug
