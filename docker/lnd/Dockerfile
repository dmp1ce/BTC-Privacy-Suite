FROM dmp1ce/lnd:0.14-beta-alpine
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
