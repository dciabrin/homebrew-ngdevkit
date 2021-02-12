#!/bin/bash
# $1: package name
set -eu
PKG=$1
MASTER_BRANCH=${2:-master}

if [ -f configure.ac ]; then
    HEAD_VERSION=$(sed -ne 's/AC_INIT.*\[\([^]]*\)\].*/\1/p' configure.ac)
elif [ -f Makefile ]; then
    HEAD_VERSION=$(sed -ne 's%VERSION=\(.*\)$%\1%p' Makefile)
else
    echo "Cannot parse head version for $PKG in $(pwd)" >&2
    exit 1
fi

HOMEBREW_BASEDIR=$(dirname $(dirname $0))
export GIT_ASKPASS=$(realpath ${HOMEBREW_BASEDIR}/.ci/git-ask-pass.sh)

git checkout ${MASTER_BRANCH}
HEAD_COMMIT_DATE=$(TZ=UTC git show --quiet --date='format-local:%Y%m%d%H%M' --format='%cd')
if ! (git tag -l | grep -q nightly/$HEAD_COMMIT_DATE); then
    echo "Tagging $PKG with new version ${HEAD_COMMIT_DATE} on tip of ${MASTER_BRANCH}"
    git tag nightly-$HEAD_COMMIT_DATE
    git push --tags
else
    echo "Tagging ${HEAD_COMMIT_DATE} for $PKG already exists, not retagging"
fi

echo "Computing archive URL and SHA256 for $PKG $HEAD_COMMIT_DATE"
ARCHIVE=$(echo "https://github.com/dciabrin/$PKG/archive/nightly-${HEAD_COMMIT_DATE}.tar.gz" | sed 's/ngdevkit-gngeo/gngeo/')
HASH=$(curl -sL $ARCHIVE | sha256sum | cut -d' ' -f1)

HOMEBREW_VERSION=${HEAD_VERSION}+${HEAD_COMMIT_DATE}-1
echo "Preparing new nightly version $HOMEBREW_VERSION of $PKG in ngdevkit tap"
cd $HOMEBREW_BASEDIR
git checkout master
sed -i -e "s%^  url.*%  url \"${ARCHIVE}\"%" -e "s%^  sha256.*%  sha256 \"${HASH}\"%" -e "s%^  version.*%  version \"${HOMEBREW_VERSION}\"%" ./Formula/$PKG.rb

NEW_NIGHTLY_VERSION=nightly/${PKG}-${HEAD_COMMIT_DATE}
git checkout -b ${NEW_NIGHTLY_VERSION}
git add ./Formula/$PKG.rb
git commit -m "Nightly build ${PKG} ${HEAD_COMMIT_DATE}"
git push -f -u origin ${NEW_NIGHTLY_VERSION}
echo "New nightly version ready to be rebuilt in homebrew"
