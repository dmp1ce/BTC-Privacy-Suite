#!/bin/sh
set -e

# Create traefik.toml if it doesn't exist
if [ ! -f "/home/traefik/data/traefik.toml" ]; then
    envsubst < /tmp/traefik.toml > /home/traefik/data/traefik.toml
fi

# Change local user id and group
usermod -u "${LOCAL_USER_ID:?}" traefik
groupmod -g "${LOCAL_GROUP_ID:?}" traefik

# Fix ownership
chown -R traefik:traefik /home/traefik/data

# Start upstream entrypoint
exec /entrypoint.sh "$@"
