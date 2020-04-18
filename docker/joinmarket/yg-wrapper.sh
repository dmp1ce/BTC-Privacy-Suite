#!/bin/bash
set -e

WALLET=${JM_WALLET_FILE:-"yg.jmdat"}
PASS=${JM_WALLET_PASSWORD:-"password"}
SCRIPT=${JM_YG_SCRIPT:-"yield-generator-basic.py"}

if [ -f "/home/joinmarket/.joinmarket/wallets/$WALLET.lock" ]; then
    echo "WARNING: Removing '$WALLET.lock' file."
    rm "/home/joinmarket/.joinmarket/wallets/$WALLET.lock"
fi

exec printf "%s" "$PASS" | python3 "$SCRIPT" "$WALLET" --wallet-password-stdin
