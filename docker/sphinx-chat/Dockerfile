FROM sphinxlightning/sphinx-relay:v2.0.14
LABEL maintainer="David Parrish <daveparrish@tutanota.com>"

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999
ARG USERNAME=node

# hadolint ignore=DL3002
USER root

# Setup user and group
# Bash auto completion for bos
# Timezone
# Cron directories for user
RUN apt-get update \
    && apt-get install --no-install-recommends -yq \
      sudo=1.* gettext-base=0.* bash-completion=1:2.* tini=0.18.*\
    && apt-get clean \
    && chown -R node:node /home/node\
    && chown -R node:node /relay\
    && usermod -u "$LOCAL_USER_ID" ${USERNAME:?}\
    && groupmod -g "$LOCAL_GROUP_ID" ${USERNAME:?}\
    && ln -sf /relay/.data/app.json /relay/dist/config/app.json\
    && ln -sf /relay/.data/config.json /relay/dist/config/config.json

COPY entrypoint.sh /root/entrypoint.sh
COPY app.json /tmp/app.json
COPY config.json /tmp/config.json
ENTRYPOINT [ "tini", "-g", "--", "/root/entrypoint.sh" ]
