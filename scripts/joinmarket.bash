#!/bin/bash

HELP="JoinMarket docker wrapper help

Commands:
  generate                                  - generate a new wallet

  display, displayall, summary, history,
  recover, changepass, showutxos, showseed,
  importprivkey, dumpprivkey, signpsbt,
  signmessage, freeze, gettimelockaddress,
  addtxoutproof, createwatchonly            - Wallet functions

  wallet-tool                               - Directly use wallet-tool.py script

  sendpayment                               - Send payment

  help                                      - This help message

Any other command is directly sent to the joinmarket service.
For example: \`./scripts/joinmarket.bash bash\` opens a bash prompt."

DAEMON_SERVICE=${DAEMON_SERVICE:-joinmarketd}

# Is Join Market enabled?
if ! ./start ps -q "$DAEMON_SERVICE" > /dev/null 2>&1; then
    echo "Join Market service ($DAEMON_SERVICE) is not currently running."
    echo "Was the Join Market override enabled?"
    echo "See: https://github.com/dmp1ce/BTC-Privacy-Suite#join-market"
    exit 1
fi

CMD=()
WALLET="${WALLET:-wallet.jmdat}"
case "$1" in
    "generate" )
        CMD=(wallet-tool.py "${@}")
        ;;
    "display" | "displayall" | "summary" | "history" | "recover" | "changepass" | "showutxos" \
        | "showseed" | "importprivkey" | "dumpprivkey" | "signpsbt" | "signmessage" \
        | "freeze" | "gettimelockaddress" | "addtxoutproof" | "createwatchonly" )
        # Assume using default options for wallet-tool.py
        CMD=(wallet-tool.py "$WALLET" "$@")
        ;;
    "wallet-tool")
        CMD=(wallet-tool.py "$WALLET" "${@:2}")
        ;;
    "sendpayment")
        CMD=(sendpayment.py "$WALLET" "${@:2}")
        ;;
    "tumbler")
        CMD=(tumbler.py "$WALLET" "${@:2}")
        ;;
    "" | "help")
        echo "$HELP"
        exit
        ;;
    *)
        END_COMMAND=("$@")
        ;;
esac

PYTHON_CMD="python3"
if [ 0 -lt "${#CMD[@]}" ]; then
    END_COMMAND=( "$PYTHON_CMD" "${CMD[@]}" )
fi

exec ./start exec --workdir=/jm/clientserver/scripts "$DAEMON_SERVICE" gosu joinmarket "${END_COMMAND[@]}"
