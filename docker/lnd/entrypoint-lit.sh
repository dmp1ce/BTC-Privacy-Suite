#!/bin/sh
set -e

# Create lit.conf if it doesn't exist
if [ ! -f "/home/lit/.lit/lit.conf" ]; then
    envsubst < /tmp/lit.conf > "${_DST_LIT_LIT:?}/lit.conf"
fi

# Change local user id and group
usermod -u "${LOCAL_USER_ID:?}" lit
usermod -u "${LOCAL_GROUP_ID:?}" lit

# Fix ownership
chown -R lit "${_DST_LIT_LIT:?}"
chown -R lit "${_DST_LIT_FARADAY:?}"
chown -R lit "${_DST_LIT_POOL:?}"
chown -R lit "${_DST_LIT_LOOP:?}"

# Start lit
exec sudo -u lit "$@"
