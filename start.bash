#!/bin/bash

# Start LND, Bitcoin and Tor with added overrides

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
echo docker-compose -f docker-compose.yml "${OVERRIDE_OPTIONS[@]}" up -d
cd "$DIR" && exec docker-compose -f docker-compose.yml "${OVERRIDE_OPTIONS[@]}" up -d
