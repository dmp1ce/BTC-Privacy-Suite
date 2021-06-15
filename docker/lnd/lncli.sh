#!/bin/sh

# Wrapper for lncli to get the right RPC port and network automatically

# Get RPC port
RPC_PORT=$(grep rpclisten ~/.lnd/lnd.conf | grep -oE "\d+$")

# Determine if testnet is set
TESTNET=$(grep bitcoin.testnet ~/.lnd/lnd.conf | grep -oE "\d+$")
if [ "$TESTNET" = 1 ]; then
    NETWORK="testnet"
fi

# Apply network, RPC port and use all arguments passed in
exec lncli ${NETWORK:+-n "$NETWORK"} --rpcserver="localhost:$RPC_PORT" "$@"
