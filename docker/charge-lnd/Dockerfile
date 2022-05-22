#FROM accumulator/charge-lnd:v0.2.10 with 'node-ratio-policies' patch
FROM dmp1ce/charge-lnd@sha256:6f10f6398b1b493a57591c7bd052ba988a89958aeda63bd73a52d45887b6e6b0
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
