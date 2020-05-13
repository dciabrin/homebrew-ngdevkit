#!/bin/bash
set -eu
# $1: branch name (e.g. nightly-ngdevkit-gngeo-202001191709)
BRANCH=$1
echo $BRANCH | sed -e 's/^nightly-\(.*\)-[0-9]*$/\1/'
