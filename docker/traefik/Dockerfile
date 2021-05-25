FROM traefik:2.4
LABEL maintainer="David Parrish <daveparrish@tutanota.com>"

# "Setup traefik.toml here with correct USERS and entrypoint so things are ready to go when starting"

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999
ARG USER=traefik
ARG GROUP=traefik

# Set the expected local user id
# Symlink to config file
RUN apk --no-cache --no-progress add shadow=~4 sudo=~1 gettext=~0.20\
    && groupadd -r $GROUP\
    && useradd --no-log-init -r -g $USER $GROUP\
    && usermod -u "$LOCAL_USER_ID" $USER\
    && groupmod -g "$LOCAL_GROUP_ID" $GROUP\
    && ln -sf /home/traefik/data/traefik.toml /traefik.toml

COPY entrypoint.sh /root/entrypoint.sh
COPY traefik.toml /tmp/traefik.toml
ENTRYPOINT [ "/root/entrypoint.sh" ]
