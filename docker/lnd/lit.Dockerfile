FROM lightninglabs/lightning-terminal:v0.5.3-alpha
LABEL maintainer="David Parrish <daveparrish@tutanota.com>"

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

# hadolint ignore=DL3002
USER root

# Set the expected local user id
# for shared group to access tor cookie
RUN apk --no-cache --no-progress add shadow=~4 sudo=~1 gettext=~0.21 \
    && groupadd -r lit\
    && useradd --no-log-init -r -g lit lit\
    && mkdir -p /home/lit\
    && chown -R lit:lit /home/lit\
    && usermod -u "$LOCAL_USER_ID" lit \
    && groupmod -g "$LOCAL_GROUP_ID" lit

COPY entrypoint-lit.sh /root/entrypoint-lit.sh
COPY lit.conf /tmp/lit.conf
ENTRYPOINT [ "/root/entrypoint-lit.sh" ]
