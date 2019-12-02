#!/bin/sh

KEYS_DIR=/root/keys
ELECTRS_KEY=$KEYS_DIR/electrs.key
ELECTRS_CERT=$KEYS_DIR/electrs.crt

mkdir -p /root/keys

if [ ! -f /root/keys/electrs.key ] || [ ! -f /root/keys/electrs.crt ]; then
    openssl req -nodes -x509 -newkey rsa:4096 \
            -keyout "$ELECTRS_KEY"\
            -out "$ELECTRS_CERT"\
            -subj '/CN=localhost'
fi

nginx -g "daemon off;"
