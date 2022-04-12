#!/bin/bash

_OPTIONS=(-c /app/charge-lnd.config)

# Run charge-lnd with the correct paths to all the needed files
HOME=/home/charge
if [ "$NETWORK" = "testnet" ]; then
    _OPTIONS=("${_OPTIONS[@]}" "--macaroon" "$HOME/.lnd/data/chain/bitcoin/testnet/admin.macaroon")
fi

echo "Running charge-lnd with --dry-run"
echo "OPTIONS: ${_OPTIONS[*]}"
exec charge-lnd "${_OPTIONS[@]}" --dry-run
