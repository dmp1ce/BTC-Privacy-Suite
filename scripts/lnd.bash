#!/bin/bash

HELP="LND docker wrapper help

Commands:
  unlock                                    - lncli commands

  macaroons NETWORK MACAROON                - Print macaroons in hex format
                                              Example: \`./scripts/lnd.bash macarrons testnet readonly\`

  help                                      - This help message

Any other command is directly sent to the LND service.
For example: \`./scripts/lnd.bash sh\` opens a shell prompt.

Override the LND service by setting the \"SERVICE\" environment variable.
Example SERVICE=lnd-secondary ./scripts/lnd.bash sh."

SERVICE=${SERVICE:-lnd}

# Is LND enabled?
if ! ./start ps -q "$SERVICE" > /dev/null 2>&1; then
    echo "LND service ($SERVICE) is not currently running."
    echo "Was the LND override enabled?"
    echo "See: https://github.com/dmp1ce/BTC-Privacy-Suite#lnd-server"
    exit 1
fi

CMD=""
case "$1" in
    "unlock" | "create" )
        CMD=(./scripts/lncli.sh "${@}")
        ;;

    "lncli")
        CMD=(./scripts/lncli.sh "${@:2}")
        ;;

    "macaroons" )
        # Print macaroons in hex format for Zeus app

        network="mainnet"
        macaroon_name="admin"

        if [ -n "$2" ]; then
            network="$2"
        fi

        if [ -n "$3" ]; then
            macaroon_name="$3"
        fi

        CMD=(./scripts/get_macaroons.sh "$network" "$macaroon_name")
        ;;

    "" | "help" | "--help" | "-h" )
        echo "$HELP"
        exit
        ;;
    *)
        CMD=("$@")
        ;;
esac

exec ./start exec -u lnd "$SERVICE" "${CMD[@]}"
