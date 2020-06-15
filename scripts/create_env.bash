# Create .env if it doesn't exist already
if [ ! -f "$DIR/.env" ]; then
    echo "Creating missing '.env' file."; echo ""
    LOCAL_USER_ID="$(id -u)" LOCAL_USER_GROUP=$(id -g) \
                 envsubst < "$DIR/.env.tpl" > "$DIR/.env"
    cat "$DIR/.env"
    echo ""; echo "Please check to make sure the configuration in '.env' is correct before running again!"
    exit 0
fi
