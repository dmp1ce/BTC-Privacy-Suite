# accumulator/charge-lnd:v0.2.12  https://hub.docker.com/layers/accumulator/charge-lnd/v0.2.12/images/sha256-a6437f5427f520490e8841de8a74ff95ac5191a51f19b100bba2a5c1e545889e?context=explore
FROM accumulator/charge-lnd@sha256:a6437f5427f520490e8841de8a74ff95ac5191a51f19b100bba2a5c1e545889e
LABEL maintainer="David Parrish <daveparrish@tutanota.com>"

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

# hadolint ignore=DL3002
USER root

# Change the user and group ids to match builder's filesystem
# Install sudo
RUN groupmod -g $LOCAL_GROUP_ID charge \
    && usermod -u $LOCAL_USER_ID -g $LOCAL_GROUP_ID charge \
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
