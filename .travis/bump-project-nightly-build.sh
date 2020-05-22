#!/bin/bash
# $1: package name
set -eu
PKG=$1

if [ -f configure.ac ]; then
    HEAD_VERSION=$(sed -ne 's/AC_INIT.*\[\([^]]*\)\].*/\1/p' configure.ac)
elif [ -f Makefile ]; then
    HEAD_VERSION=$(sed -ne 's%VERSION=\(.*\)$%\1%p' Makefile)
else
    echo "Cannot parse head version for $PKG in $(pwd)" >&2
    exit 1
fi

HOMEBREW_BASEDIR=$(dirname $(dirname $0))
export GIT_ASKPASS=$(realpath ${HOMEBREW_BASEDIR}/.travis/git-ask-pass.sh)

# TODO: do not push tag if it already exist
git checkout master
HEAD_COMMIT_DATE=$(TZ=UTC git show --quiet --date='format-local:%Y%m%d%H%M' --format='%cd')
echo "Tagging $PKG with new version HEAD_COMMIT_DATE in master"
git tag nightly-$HEAD_COMMIT_DATE
git push --tags

echo "Computing archive URL and SHA256 for $PKG $HEAD_COMMIT_DATE"
ARCHIVE="https://github.com/dciabrin/$PKG/archive/nightly-${HEAD_COMMIT_DATE}.tar.gz"
HASH=$(curl -sL $ARCHIVE | sha256sum | cut -d' ' -f1)

HOMEBREW_VERSION=${HEAD_VERSION}+${HEAD_COMMIT_DATE}-1
echo "Preparing new nightly version $HOMEBREW_VERSION of $PKG in ngdevkit tap"
cd $HOMEBREW_BASEDIR
git checkout master
sed -i -e "s%^  url.*%  url \"${ARCHIVE}\"%" -e "s%^  sha256.*%  sha256 \"${HASH}\"%" -e "s%^  version.*%  version \"${HOMEBREW_VERSION}\"%" ./Formula/$PKG.rb

# TODO: delete nightly branch if it already exists
NEW_NIGHTLY_VERSION=nightly-${PKG}-${HEAD_COMMIT_DATE}
git checkout -b ${NEW_NIGHTLY_VERSION}
git add ./Formula/$PKG.rb
git commit -m "Nightly build ${PKG} ${HEAD_COMMIT_DATE}"
git push -u origin ${NEW_NIGHTLY_VERSION}
echo "New nightly version ready to be rebuilt in homebrew"
