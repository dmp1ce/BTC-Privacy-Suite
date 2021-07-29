#!/bin/bash

HELP="bos docker wrapper help

Commands:
  help                                      - This help message

Any other command is directly sent to the bos service.
For example: \`./scripts/bos.bash bash\` opens a shell prompt.

Override the bos service by setting the \"SERVICE\" environment variable.
Example SERVICE=bos-secondary ./scripts/bos.bash bash."


SERVICE=${SERVICE:-bos}

# Is bos enabled?
if ! ./start ps -q "$SERVICE" > /dev/null 2>&1; then
    echo "bos service ($SERVICE) is not currently running."
    echo "Was the bos override enabled?"
    echo "See: https://github.com/dmp1ce/BTC-Privacy-Suite"
    exit 1
fi

CMD=""
case "$1" in
    "" | "help" | "--help" | "-h" )
        echo "$HELP"
        exit
        ;;
    *)
        CMD=("$@")
        ;;
esac

exec ./start exec -u node "$SERVICE" "${CMD[@]}"
