FROM alexbosworth/balanceofsatoshis
LABEL maintainer="David Parrish <daveparrish@tutanota.com>"

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999
ARG USERNAME=node

# hadolint ignore=DL3002
USER root

# Setup user and group
# Bash auto completion for bos
RUN apt-get update \
    && apt-get install --no-install-recommends -yq \
      sudo=1.* gettext-base=0.* bash-completion=1:2.* \
    && apt-get clean \
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
