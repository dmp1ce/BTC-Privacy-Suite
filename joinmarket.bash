#!/bin/bash

HELP="JoinMarket docker wrapper help

Commands:
  generate                                  - generate a new wallet

  display, displayall, summary, history,
  recover, showseed, importprivkey,
  dumpprivkey, signmessage, freeze          - Wallet functions

  wallet-tool                               - Directly use wallet-tool.py script

  sendpayment                               - Send payment

  help                                      - This help message

Any other command is directly sent to the joinmarket service.
For example: \`./joinmarket.bash bash\` opens a bash prompt."

CMD=""
WALLET="${WALLET:-wallet.jmdat}"
case "$1" in
    "generate" )
        CMD="wallet-tool.py $*"
        ;;
    "display" | "displayall" | "summary" | "history" | "recover" \
        | "showseed" | "importprivkey" | "dumpprivkey" | "signmessage" | "freeze" )
        # Assume using default options for wallet-tool.py
        CMD="wallet-tool.py $WALLET $*"
        ;;
    "wallet-tool")
        CMD="wallet-tool.py $WALLET ${*:2}"
        ;;
    "sendpayment")
        CMD="sendpayment.py $WALLET ${*:2}"
        ;;
    "" | "help")
        echo "$HELP"
        exit
        ;;
    *)
        END_COMMAND="$*"
        ;;
esac

PYTHON_CMD="python3 "
if [ -n "$CMD" ]; then
    END_COMMAND="$PYTHON_CMD$CMD"
fi

exec ./start.bash exec --workdir=/jm/clientserver/scripts joinmarket-yg1 gosu joinmarket "$END_COMMAND"
