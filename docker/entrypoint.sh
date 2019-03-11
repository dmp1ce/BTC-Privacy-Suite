#!/bin/sh
set -e

# Create lnd.conf if it doesn't exist
if [ ! -f "/home/alice/.lnd/lnd.conf" ]; then
    cp /tmp/lnd.conf /home/alice/.lnd/lnd.conf
fi

# Create bitcoin.conf if it doesn't exist
if [ ! -f "/home/alice/.bitcoin/bitcoin.conf" ]; then
    cp /tmp/bitcoin.conf /home/alice/.bitcoin/bitcoin.conf
fi

# Create torrc if it doesn't exist
if [ ! -f "/etc/tor/torrc" ]; then
    cp /tmp/torrc /etc/tor/torrc
fi

usermod -u "$LOCAL_USER_ID" alice
groupmod -g "$LOCAL_USER_ID" alice

# Set correct owners on volumes
chown -R tor:"${LOCAL_USER_ID}" "${TOR_DATA}"
chown -R :"${LOCAL_USER_ID}" /etc/tor
chown -R "${LOCAL_USER_ID}":"${LOCAL_USER_ID}" /home/alice
chown -R :"${LOCAL_USER_ID}" /root/logfiles

echo
cd /root || exit
exec supervisord --nodaemon --configuration /etc/supervisord.conf
