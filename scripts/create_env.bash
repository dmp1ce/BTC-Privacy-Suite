#!/bin/bash

continueYN() {
    read -r -p "Continue (y/n)?" choice
    case "$choice" in
        y|Y ) ;;
        * ) echo "Exiting"; exit 0;;
    esac
}

# Create global .env if it doesn't exist already
if [ ! -f "$DIR/.env" ]; then
    echo "Creating missing '.env' file."; echo ""
    LOCAL_USER_ID="$(id -u)" LOCAL_USER_GROUP=$(id -g) \
                 envsubst < "$DIR/.env.tpl" > "$DIR/.env"
    cat "$DIR/.env"
    echo ""; echo "Please check to make sure the configuration in '.env' is \
correct before continuing!"

    continueYN
fi

# Create additional environment variable files for activated overrides
required_envs=$(grep -ho "\w\+\.env" "$DIR"/overrides/*.yml)
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
