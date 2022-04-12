#!/bin/bash

USERNAME=${USERNAME:=charge}
GROUPNAME=${GROUPNAME:=charge}

# Change local user id and group
groupmod -g "${LOCAL_GROUP_ID:?}" "$GROUPNAME"
usermod -u "${LOCAL_USER_ID:?}" -g "${LOCAL_GROUP_ID:?}" "$USERNAME"

# Fix ownership
find /home/charge\
     -path /home/charge/.lnd -prune\
     -o -exec chown $USERNAME:$GROUPNAME {} +
chown -R $USERNAME:$GROUPNAME /app

# Copy config file if it doesn't exit
if [ ! -f "/app/charge-lnd.config" ]; then sudo -u charge cp /home/charge/charge-lnd.config /app/charge-lnd.config; fi

# Just keep running for scheduling periodic charge-lnd commands
trap : TERM INT
tail -f /dev/null & wait
