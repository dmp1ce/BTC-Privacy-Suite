#!/bin/bash
set -e

WALLET=${JM_WALLET_FILE:-"yg.jmdat"}
PASS=${JM_WALLET_PASSWORD:-"password"}
SCRIPT=${JM_YG_SCRIPT:-"yield-generator-basic.py"}

exec printf "%s" "$PASS" | python3 "$SCRIPT" "$WALLET" --wallet-password-stdin
