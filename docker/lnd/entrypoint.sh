#!/bin/sh
set -e

# Create lnd.conf if it doesn't exist
if [ ! -f "/home/lnd/.lnd/lnd.conf" ]; then
    envsubst < /tmp/lnd.conf > /home/lnd/.lnd/lnd.conf
fi

# Change local user id and group
if [ -n "${LOCAL_USER_ID}" ]; then
    usermod -u "$LOCAL_USER_ID" lnd
    groupmod -g "$LOCAL_USER_ID" lnd
fi

# Fix ownership
chown -R lnd /home/lnd

#pwd
#ls -alh /home/lnd/.lnd

# Start lnd
exec sudo -u lnd "$@"
