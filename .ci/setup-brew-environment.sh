#!/bin/sh

set -eu

help() {
    echo "Usage: $0 [--update]" >&2
    echo "Set up the brew environment to use this local tap"
    echo ""
    echo "Options:"
    echo "  --update: update the brew environment before configuring the tap"
    exit ${1:-0}
}

while true; do
    case "${1:-}" in
        --help) help;;
        --update) UPDATE=1; shift ;;
        * ) break ;;
    esac
done

if [ -n "${UPDATE:-}" ]; then
    echo "Updating the current brew environment"
    # Start from a fresh brew env to test our brew package
    pushd "$(brew --repo)" && git fetch && git reset --hard origin/master && popd
    brew update

    echo "Workaround for actions/setup-python#577"
    # Temporary workaround for https://github.com/actions/setup-python/issues/577
    # Updating python during the brew build seems to confuse brew with:
    #    The formula built, but is not symlinked into /usr/local
    #    Error: The `brew link` step did not complete successfully
    #    Could not symlink bin/2to3
    set -x
    rm -f /usr/local/bin/2to3 /usr/local/bin/2to3-3.*
    rm -f /usr/local/bin/idle3 /usr/local/bin/idle3.*
    rm -f /usr/local/bin/pydoc3 /usr/local/bin/pydoc3.*
    rm -f /usr/local/bin/python3 /usr/local/bin/python3.*
    rm -f /usr/local/bin/python3-config /usr/local/bin/python3-config.*
fi

brewpwd=$(brew --repo dciabrin/ngdevkit)
if [ -d $brewpwd ]; then
    olddir=$(mktemp -d)
    echo "Moving brew's ngdevkit tap to $olddir"
    mv $brewpwd $olddir
fi

echo "Make brew use this repository as the current ngdevkit tap"
# create directories up to .../dciabrin/
mkdir -p $(dirname $brewpwd)
# link current repo to .../dciabrin/ngdevkit
ln -s $PWD $brewpwd
