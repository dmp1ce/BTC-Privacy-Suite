#!/bin/bash

USERNAME=${USERNAME:=node}
GROUPNAME=${GROUPNAME:=node}

# Change local user id and group
usermod -u "${LOCAL_USER_ID:?}" "$USERNAME"
groupmod -g "${LOCAL_GROUP_ID:?}" "$GROUPNAME"

# Create configuration files if they don't exist
if [ ! -f "/relay/.data/config.json" ]; then
    envsubst < /tmp/config.json > /relay/.data/config.json
fi
if [ ! -f "/relay/.data/app.json" ]; then
    envsubst < /tmp/app.json > /relay/.data/app.json
fi

# Fix ownership
chown -R $USERNAME:$GROUPNAME /relay/*
chown -R $USERNAME:$GROUPNAME /relay/.data

exec sudo -E -u node node /relay/dist/app.js
