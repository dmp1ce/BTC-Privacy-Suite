# https://hub.docker.com/layers/alexbosworth/balanceofsatoshis/15.8.11/images/sha256-90e67a1fe732b65e195aa67b8e925cac0a7ccf554a69be72936fefb6343678a5?context=explore
FROM alexbosworth/balanceofsatoshis@sha256:90e67a1fe732b65e195aa67b8e925cac0a7ccf554a69be72936fefb6343678a5
LABEL maintainer="David Parrish <daveparrish@tutanota.com>"

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999
ARG USERNAME=node

# hadolint ignore=DL3002
USER root

# Setup user and group
RUN apk --no-cache --no-progress add shadow=~4 sudo=~1 gettext=~0.21 bash=~5 bash-completion=~2\
    && chown -R node:node /home/node\
    && chown -R node:node /app/bos\
    && usermod -u "$LOCAL_USER_ID" $USERNAME\
    && groupmod -g "$LOCAL_GROUP_ID" $USERNAME\
    && echo 'source <(bos completion bash)' | tee -a /home/$USERNAME/.bashrc\
    && ln -s /app/bos /usr/local/bin

WORKDIR /home/$USERNAME

COPY entrypoint.sh /root/entrypoint.sh
COPY unlock_file /tmp/unlock_file
ENTRYPOINT [ "/root/entrypoint.sh" ]
