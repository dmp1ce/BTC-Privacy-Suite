#!/bin/bash

# Print onion addresses

electrs_onion="$(docker-compose exec -u tor tor cat /var/lib/tor/electrs/hostname)"
bitcoin_onion="$(docker-compose exec -u bitcoin bitcoin bitcoin-cli getnetworkinfo | python3 -c "import sys, json; print(json.load(sys.stdin)['localaddresses'][0]['address'])")"

echo "Bitcoin Server: $bitcoin_onion"
echo "Electrum Server: $electrs_onion"
