#!/bin/bash

CMD=""
WALLET_FILE="wallet.jmdat"
case "$1" in
    "generate" )
        CMD=" wallet-tool.py $*"
        ;;
    "display" | "displayall" | "summary" | "history" | "recover" \
        | "showseed" | "importprivkey" | "dumpprivkey" | "signmessage" | "freeze" )
        # Assume using default options for wallet-tool.py
        CMD=" wallet-tool.py $WALLET_FILE $*"
        ;;
    "wallet-tool")
        CMD=" wallet-tool.py $WALLET_FILE ${*:2}"
        ;;
    "sendpayment")
        CMD=" sendpayment.py $WALLET_FILE ${*:2}"
        ;;
    *)
        END_COMMAND=" && $*"
        ;;
esac

PYTHON_CMD=" && python "
if [ -n "$CMD" ]; then
    END_COMMAND="$PYTHON_CMD$CMD"
fi

exec docker-compose exec joinmarket gosu joinmarket bash -c "source jmvenv/bin/activate && cd working$END_COMMAND"
