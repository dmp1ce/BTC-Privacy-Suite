#!/bin/sh
set -e

# Create lit.conf if it doesn't exist
if [ ! -f "/home/lit/.lit/lit.conf" ]; then
    envsubst < /tmp/lit.conf > /home/lit/.lit/lit.conf
fi

# Change local user id and group
if [ -n "${LOCAL_USER_ID}" ]; then
    usermod -u "$LOCAL_USER_ID" lit
fi
if [ -n "${LOCAL_GROUP_ID}" ]; then
    groupmod -g "$LOCAL_GROUP_ID" lit
fi

# Fix ownership
chown -R lit /home/lit/.lit
chown -R lit /home/lit/.faraday
chown -R lit /home/lit/.pool
chown -R lit /home/lit/.loop

# Start lit
exec sudo -u lit "$@"
