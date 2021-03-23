#!/bin/bash
set -e

WALLET=${JM_WALLET_FILE:-"yg.jmdat"}
PASS=${JM_WALLET_PASSWORD:-"password"}
SCRIPT=${JM_YG_SCRIPT:-"yield-generator-basic.py"}

ORDERTYPE=${JM_ORDERTYPE:-"reloffer"}
TXFEE=${JM_TXFEE:-"0"}
TXFEE_FACTOR=${JM_TXFEE_FACTOR:-"0.3"}
CJFEE_A=${JM_CJFEE_A:-"500"}
CJFEE_R=${JM_CJFEE_R:-"0.00002"}
CJFEE_FACTOR=${JM_CJFEE_FACTOR:-"0.1"}
MINSIZE=${JM_MINSIZE:-"100000"}
SIZE_FACTOR=${JM_SIZE_FACTOR:- 0.1}
GAPLIMIT=${JM_GAPLIMIT:-"6"}

exec printf "%s" "$PASS" | python3 "$SCRIPT" "$WALLET" -o "$ORDERTYPE" -t "$TXFEE" -f "$TXFEE_FACTOR" -a "$CJFEE_A" -r "$CJFEE_R" -j "$CJFEE_FACTOR" -s "$MINSIZE" -z "$SIZE_FACTOR" -g "$GAPLIMIT" --wallet-password-stdin
