#!/bin/bash

# Copyright (c) 2020 Damien Ciabrini
# This file is part of ngdevkit


# Disable verbose to prevent leaking credentials
set +x


help() {
    echo "Usage: $0 -u {user} -r {repo} -t {github-api-token} -b {branch-regex}" >&2
    exit ${1:-0}
}

error() {
    echo "Error: $1" >&2
    help 1
}

check() {
    if [ $2 != 200 ] && [ $2 != 204 ]; then
        error "unexpected return from '$1' ($2). Aborting"
    fi
}

# ----------------- config parsing -----------------
#
USER=$(echo ${TRAVIS_REPO_SLUG:-} | cut -d'/' -f1)
REPO=$(echo ${TRAVIS_REPO_SLUG:-} | cut -d'/' -f2)
GITHUB_TOKEN=${GH_TOKEN:-}
BRANCH_REGEX=
DRYRUN=

# assume getopt is the BSD variant, with only short options
OPTS=$(/usr/bin/getopt hdu:r:t:b: $@)
if [ $? != 0 ]; then
    error "parsing arguments failed"
fi

eval set -- "$OPTS"
while true; do
    case "$1" in
        -h) help;;
        -d ) DRYRUN=1; shift ;;
        -u ) USER="$2"; shift 2 ;;
        -r ) REPO="$2"; shift 2 ;;
        -t ) GITHUB_TOKEN="$2"; shift 2 ;;
        -b ) BRANCH_REGEX="$2"; shift 2 ;;
        -- ) shift; break ;;
        * ) break ;;
    esac
done

if [ -z "$USER" ]; then
    error "no user specified"
fi
if [ -z "$REPO" ]; then
    error "no repository specified"
fi
if [ -z "$GITHUB_TOKEN" ]; then
    error "no token/password specified for GitHub API credentials"
fi
if [ -z "$BRANCH_REGEX" ]; then
    error "no branch regex specified, cannot filter which branch to remove"
fi
CREDS=$USER:$GITHUB_TOKEN


# ----------------- garbage-collect nightly branches that match regex -----------------
#
echo "Downloading branch list from $REPO..."
ret=$(curl -s -w "%{http_code}" -X GET -u $CREDS https://api.github.com/repos/$USER/$REPO/git/refs -o branches)
check "downloading list of nightly branches" $ret

# all branches to remove
branches_rm=$(jq -r '.[] | select(.ref | test("'"$BRANCH_REGEX"'")) | .ref' branches)
if [ -n "$branches_rm" ]; then
    echo "Deleting all the nightly branches matching '$BRANCH_REGEX'"
else
    echo "  (no nightly branches detected)"
fi

for i in $branches_rm; do
    echo "removing nightly branch $i"
    if [ -z "$DRYRUN" ]; then
        ret=$(curl -s -w "%{http_code}" -X DELETE -u $CREDS https://api.github.com/repos/$USER/$REPO/git/$i)
        check "removing nightly branch $i" $ret
        sleep 0.5
    fi
done
