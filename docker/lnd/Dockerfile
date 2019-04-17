FROM dmp1ce/lnd:0.6-beta-alpine

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

USER root

# Set the expected local user id
# for shared group to access tor cookie
RUN apk -U --no-progress update && apk -U --no-progress upgrade && \
    apk -U --no-progress add -u shadow sudo gettext && \
    usermod -u "$LOCAL_USER_ID" lnd && \
    groupmod -g "$LOCAL_GROUP_ID" lnd

COPY entrypoint.sh /root/entrypoint.sh
COPY lnd.conf /tmp/lnd.conf
ENTRYPOINT [ "/root/entrypoint.sh" ]
