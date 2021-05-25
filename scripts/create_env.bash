#!/bin/bash

DIR=${DIR:-.}

# shellcheck source=continueYN.bash
. "$DIR/scripts/continueYN.bash"

# Create global .env if it doesn't exist already
if [ ! -f "$DIR/.env" ]; then
    echo "Creating missing '.env' file."; echo ""
    LOCAL_USER_ID=$(id -u "${USER:?}") LOCAL_USER_GROUP=$(id -g "${USER:?}") \
                 envsubst < "$DIR/.env.tpl" > "$DIR/.env"
    cat "$DIR/.env"
    echo ""; echo "Please check to make sure the configuration in '.env' is \
correct before continuing!"

    continueYN
fi

# Create additional environment variable files for activated overrides
if compgen -G "${DIR}/overrides/*.yml" > /dev/null; then
    required_envs=$(grep -ho "[a-zA-Z0-9_-]\+\.env" "$DIR"/overrides/*.yml "$DIR"/docker-compose.yml)
else
    required_envs=$(grep -ho "[a-zA-Z0-9_-]\+\.env" "$DIR"/docker-compose.yml)
fi

for e in $required_envs
do
    env_full_filename="$DIR/env/$e"
    if [ ! -f "$env_full_filename" ]; then
        cp "$DIR/env/$e.tpl" "$env_full_filename"

        echo "Creating missing '${env_full_filename##*/}' file."; echo ""
        cat "${env_full_filename}"
        echo ""; echo "Please make sure the configuration is correct for \
'env/${env_full_filename##*/}' before continuing!"

        continueYN
    fi
done
