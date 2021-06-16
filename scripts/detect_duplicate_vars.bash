#!/bin/bash

# Loop through each env file which is known to be in use and try to find duplicate variables

DIR=${DIR:-.}

# shellcheck source=continueYN.bash
. "$DIR/scripts/continueYN.bash"

# Loop through each yml file
for yml in "$DIR"/overrides/*.yml "$DIR"/docker-compose.yml; do

    mapfile -t required_envs < <(grep -ho "env\/[a-zA-Z0-9_-]\+\.env" "$yml")

    # Always add .env
    required_envs+=(".env")

    # For the second loop
    required_envs2=( "${required_envs[@]}" )

    # Loop through all env files looking for any duplicate variables in different files.
    for e in "${required_envs[@]}"; do

        # Use realpath for greps to work
        e_real=$(realpath "$e")

        # Remove env files already searched as not to give duplicate warnings
        required_envs2=( "${required_envs2[@]/$e}" )

        for e2 in "${required_envs2[@]}"; do
            if [ "$e" = "$e2" ]; then continue; fi
            if [ "$e2" = "" ]; then continue; fi

            # Use realpath for greps to work
            e2_real=$(realpath "$e2")

            dup_detected=0
            while IFS= read -r k; do
                while IFS= read -r k2; do
                    if [ "$k" = "$k2" ] ; then
                        echo "WARNING: Detected duplicate variable '$k' in '$e' and '$e2' env files reference by '$yml'!"
                        dup_detected=1
                    fi
                done < <(grep -ho "^[a-zA-Z0-9_-]\+" < "$e2_real")
            done < <(grep -ho "^[a-zA-Z0-9_-]\+" < "$e_real")

            if [ $dup_detected = 1 ]; then continueYN; fi
        done
    done
done
