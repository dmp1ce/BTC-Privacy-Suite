FROM shahanafarooqui/rtl:0.10.2
LABEL maintainer="David Parrish <daveparrish@tutanota.com>"

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

# hadolint ignore=DL3002
USER root

RUN apk --no-cache --no-progress add shadow=~4 sudo=~1 gettext=~0.20\
    && chown -R node:node /home/node\
    && usermod -u "$LOCAL_USER_ID" node\
    && groupmod -g "$LOCAL_GROUP_ID" node

COPY entrypoint.sh /root/entrypoint.sh
COPY RTL-Config.json /root/RTL-Config.json
ENTRYPOINT [ "/sbin/tini", "-g", "--", "/root/entrypoint.sh" ]
