#!/bin/bash

# Start LND, Bitcoin and Tor with added overrides

CMD=""
case "$1" in
    "help" )
        echo "Start services with overrides. Supported parameters are 'up' and 'restart'."
        echo "Example: \`./start restart bitcoin\`"
        echo ""
        echo "Default command is \`up -d\`"
        exit 0
        ;;
    "restart" | "up" | "logs" | "ps" | "stop" | "exec" | "kill" | "rm" )
        read -r -a CMD <<< "$@"
        ;;
    *)
        CMD=(up -d)
        ;;
esac

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Get list of overrides
OVERRIDE_OPTIONS=()
shopt -s nullglob
for f in "$DIR/overrides"/*.yml
do
    OVERRIDE_OPTIONS+=(-f)
    OVERRIDE_OPTIONS+=("$f")
done

# Start docker-compose with override options
echo docker-compose -f docker-compose.yml "${OVERRIDE_OPTIONS[@]}" "${CMD[@]}"
cd "$DIR" && exec docker-compose -f docker-compose.yml "${OVERRIDE_OPTIONS[@]}" "${CMD[@]}"
