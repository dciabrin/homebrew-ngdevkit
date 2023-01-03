#!/bin/sh
set -eux

# Always start from a fresh brew env to test our brew package
brew update

# Temporary workaround for https://github.com/actions/setup-python/issues/577
# Updating python during the brew build seems to confuse brew with:
#    The formula built, but is not symlinked into /usr/local
#    Error: The `brew link` step did not complete successfully
#    Could not symlink bin/2to3
rm -f /usr/local/bin/2to3
rm -f /usr/local/bin/idle3
rm -f /usr/local/bin/pydoc3
rm -f /usr/local/bin/python3
rm -f /usr/local/bin/python3-config
