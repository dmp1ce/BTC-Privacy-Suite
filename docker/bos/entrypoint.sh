#!/bin/bash

USERNAME=${USERNAME:=node}
GROUPNAME=${GROUPNAME:=node}

# Change local user id and group
usermod -u "${LOCAL_USER_ID:?}" "$USERNAME"
groupmod -g "${LOCAL_GROUP_ID:?}" "$GROUPNAME"

# Create unlock_file if it doesn't exist
if [ ! -f "/home/$USERNAME/.data/unlock_file" ]; then
    envsubst < /tmp/unlock_file > /home/$USERNAME/.data/unlock_file
fi

# Fix ownership
chown -R $USERNAME:$GROUPNAME /home/"$USERNAME"/.data

# Just keep running for scheduling periodic bos commands
trap : TERM INT
tail -f /dev/null & wait
