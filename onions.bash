#!/bin/bash

# Print onion addresses

electrs_onion="$(docker-compose exec -u tor tor cat /var/lib/tor/electrs/hostname)"

echo "Electrum Server: $electrs_onion"
