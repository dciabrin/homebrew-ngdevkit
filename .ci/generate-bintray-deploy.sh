#!/bin/bash
# $1: package name
# $2: bintray template file
TEMPLATE=$2
PKG=$1
VCS=$(sed -ne 's%^ *url.*"\(http.*\)/archive.*%\1%p' Formula/$PKG.rb)
VERSION=$(jq -r '."dciabrin/ngdevkit/'$PKG'".formula.pkg_version' $PKG*.json)
DATE=$(echo $VERSION | sed 's/.*+\(....\)\(..\)\(..\).*/\1-\2-\3/')
DESC="Nightly build - $DATE"
jq -n --arg PKG "$PKG" --arg PATTERN "./(($PKG)-*(.*\\.bottle\\.tar\\.gz))" --arg VCS "$VCS" --arg VERSION "$VERSION" --arg DATE "$DATE" --arg DESC "$DESC" -f $TEMPLATE
