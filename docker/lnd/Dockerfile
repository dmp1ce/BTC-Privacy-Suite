# version 0.16.3-beta-alpine https://hub.docker.com/layers/dmp1ce/lnd/0.16.3-beta-alpine/images/sha256-9a56e820f81e9cba2fd5d298f9b6d3a22bb922aada31e59fb61a8e8e949b0541?context=repo
FROM dmp1ce/lnd@sha256:9a56e820f81e9cba2fd5d298f9b6d3a22bb922aada31e59fb61a8e8e949b0541
LABEL maintainer="David Parrish <daveparrish@tutanota.com>"

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

# hadolint ignore=DL3002
USER root

# Set the expected local user id
# for shared group to access tor cookie
RUN apk --no-cache --no-progress add shadow=~4 sudo=~1 gettext=~0.21 && \
    usermod -u "$LOCAL_USER_ID" lnd && \
    groupmod -g "$LOCAL_GROUP_ID" lnd

USER lnd
RUN mkdir /home/lnd/scripts
COPY get_macaroons.sh /home/lnd/scripts/get_macaroons.sh
COPY lncli.sh /home/lnd/scripts/lncli.sh

# hadolint ignore=DL3002
USER root
RUN chmod +x /home/lnd/scripts/get_macaroons.sh
RUN chmod +x /home/lnd/scripts/lncli.sh
COPY entrypoint.sh /root/entrypoint.sh
COPY lnd.conf /tmp/lnd.conf
ENTRYPOINT [ "/root/entrypoint.sh" ]
