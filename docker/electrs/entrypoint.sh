#!/bin/sh
set -e

# Create config file if it doesn't already exist
if [ ! -f "/home/user/.electrs/config.toml" ]; then
    envsubst < /tmp/electrs.toml > /home/user/.electrs/config.toml
fi

# Change local user id and group
usermod -u "${LOCAL_USER_ID:?}" user
groupmod -g "${LOCAL_GROUP_ID:?}" user

# Fix ownership
chown -R user /home/user/.electrs

# Start electrs
exec sudo -u user "$@"
