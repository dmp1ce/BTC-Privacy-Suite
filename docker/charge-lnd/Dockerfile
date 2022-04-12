FROM accumulator/charge-lnd:v0.2.10
LABEL maintainer="David Parrish <daveparrish@tutanota.com>"

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999
ARG USERNAME=charge

# hadolint ignore=DL3002
USER root

# Change the user and group ids to match builder's filesystem
# Install sudo
RUN usermod -u $LOCAL_USER_ID -g $LOCAL_GROUP_ID $USERNAME \
    && chown -R $LOCAL_USER_ID:$LOCAL_GROUP_ID /home/charge \
    && chown -R $LOCAL_USER_ID:$LOCAL_GROUP_ID /app \
    && apt-get update \
    && apt-get install --no-install-recommends -yq \
    sudo=1.* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /root/entrypoint.sh
COPY charge-lnd.config /home/charge/charge-lnd.config
COPY charge-lnd-wrapper.bash /home/charge/charge-lnd-wrapper.bash
ENTRYPOINT [ "/root/entrypoint.sh" ]
