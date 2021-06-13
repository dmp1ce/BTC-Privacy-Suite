#!/bin/bash

# Print onion addresses
RUNNING_SERVICES=$(./start ps --services --filter status=running)

FOUND_ONION=
for s in $RUNNING_SERVICES; do
    # ElectRS onion
    if [[ "$s" == electrs ]]; then
        electrs_onion="$(./start exec -u tor tor cat /var/lib/tor/electrs/hostname)"
        echo "Electrum Server: $electrs_onion"
        FOUND_ONION=1
    fi

    # Bitcoin onion
    if [[ $s == bitcoin ]]; then
        bitcoin_onion="$(./start exec -u bitcoin bitcoin bitcoin-cli getnetworkinfo | python3 -c "import sys, json; print(json.load(sys.stdin)['localaddresses'][0]['address'])")"
        echo "Bitcoin Server: $bitcoin_onion"
        FOUND_ONION=1
    fi

    # LND onion
    if [[ $s == *lnd* ]]; then
        lnd_onion="$(./start lnd lncli getinfo | python3 -c "import sys, json; print(json.load(sys.stdin)['uris'][0])")"
        echo "$s server: $lnd_onion"
        FOUND_ONION=1
    fi
done

if [[ FOUND_ONION -eq 0 ]]; then
    echo "No onions available for services:"
    echo "$RUNNING_SERVICES"
fi
