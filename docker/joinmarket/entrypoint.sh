#!/bin/bash
set -e

chown joinmarket: /jm/clientserver/working

# Create config file if it doesn't already exist
if [ ! -f "/jm/clientserver/working/joinmarket.cfg" ]; then
    envsubst < /tmp/joinmarket.cfg > /jm/clientserver/working/joinmarket.cfg
    chown joinmarket: /jm/clientserver/working/joinmarket.cfg
    ls -alh /jm/clientserver/working
fi

if [ ! -L "/jm/clientserver/working/joinmarketd.py" ]; then
    gosu joinmarket ln -s /jm/clientserver/scripts/*.py /jm/clientserver/working
    gosu joinmarket mkdir -p /jm/clientserver/working/wallets
    ls -alh /jm/clientserver/working
fi

# Change local user id and group
if [ -n "${LOCAL_USER_ID}" ]; then
    usermod -u "$LOCAL_USER_ID" joinmarket
fi
if [ -n "${LOCAL_GROUP_ID}" ]; then
    groupmod -g "$LOCAL_GROUP_ID" joinmarket
fi

# Start joinmarket
exec gosu joinmarket bash -c "source jmvenv/bin/activate && cd working && $*"
