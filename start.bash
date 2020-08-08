#!/bin/bash

# Check for verbose
if [ "$1" == "-v" ]; then
    VERBOSE=true
    shift 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

HELP="Start services with overrides. Supported parameters are 'up' and 'restart'.
Example: \`./start restart bitcoin\`

Commands:
  restart, up, logs, ps, stop, exec, kill, rm, run, config      - Docker Compose commands
                                                                  Example: ./start logs -f bitcoin

  jm                                                            - Shortcut command to scripts/joinmarket.bash
                                                                  Example: ./start.bash jm display

  macaroons                                                     - Shortcut command to scripts/macaroons.bash

  onions                                                        - Shortcut command to scripts/onions.bash

  help                                                          - Displays this message.

The default command (no parameters) is \`up -d\`
"


# shellcheck source=scripts/create_env.bash
. "$DIR/scripts/create_env.bash"

# Start LND, Bitcoin and Tor with added overrides
CMD=""
case "$1" in
    "restart" | "up" | "logs" | "ps" | "stop" | "exec" | "kill" | "rm" | "run" | "config" )
        read -r -a CMD <<< "$@"
        ;;
    "jm")
        scripts/joinmarket.bash "${*:2}"
        exit 0
        ;;
    "onions")
        scripts/onions.bash "${*:2}"
        exit 0
        ;;
    "macaroons")
        scripts/macaroons.bash "${*:2}"
        exit 0
        ;;
    "")
        CMD=(up -d)
        ;;
    "help")
        echo "$HELP"
        exit 0
        ;;
    * )
        echo "Command '${*:1}' not recognized."
        echo "$HELP"
        exit 0
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
if [ "$VERBOSE" ]; then
   echo docker-compose -f docker-compose.yml "${OVERRIDE_OPTIONS[@]}" "${CMD[@]}"
fi
cd "$DIR" && exec docker-compose -f docker-compose.yml "${OVERRIDE_OPTIONS[@]}" "${CMD[@]}"
