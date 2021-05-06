#!/bin/sh
set -e

USERNAME=${USERNAME:=node}
GROUPNAME=${GROUPNAME:=node}

# Change local user id and group
usermod -u "${LOCAL_USER_ID:?}" "$USERNAME"
groupmod -g "${LOCAL_GROUP_ID:?}" "$GROUPNAME"

# Fix the permissions on RTL-Config.json and put in volume directory
if [ ! -f /home/$USERNAME/.rtl/RTL-Config.json ]; then
    envsubst < /root/RTL-Config.json > /home/$USERNAME/.rtl/RTL-Config.json
fi
ln -fs /home/$USERNAME/.rtl/RTL-Config.json /RTL/RTL-Config.json

# Fix ownership
chown -R "$USERNAME" /home/"$USERNAME"/.rtl

#groups
#ls -alh /RTL

cat /RTL/RTL-Config.json

exec sudo -u node "$@"
