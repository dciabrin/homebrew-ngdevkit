#!/bin/bash
# $1: package name
set -e
PKG=$1
PKG_VERSION=$(sed -ne 's/.*version.*"\([^"]*\)".*/\1/p' Formula/$PKG.rb | head -1)
curl -s -X POST -u dciabrin:$BINTRAY_API_KEY "https://api.bintray.com/content/dciabrin/bottles-ngdevkit/$PKG/${PKG_VERSION}/publish"
echo
echo "All bottles for $PKG compiled and published, branch $TRAVIS_BRANCH is ready to be merged in master"
