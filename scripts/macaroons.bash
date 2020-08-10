#!/bin/bash

# Print macaroons in hex format for Zeus app

network="mainnet"
macaroon_name="admin"

if [ -n "$1" ]; then
    network="$1"
fi

if [ -n "$2" ]; then
    macaroon_name="$2"
fi

./start exec -u lnd lnd ./scripts/get_macaroons.sh "$network" "$macaroon_name"
