FROM dmp1ce/joinmarket:0.6.2

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

# Set the expected local user id
# for shared group to access tor cookie
# hadolint ignore=DL3002
USER root
# hadolint ignore=DL3008
RUN apt-get update \
  && apt-get install -yq --no-install-recommends gettext-base python3-nacl \
  && usermod -u "$LOCAL_USER_ID" joinmarket \
  && usermod -u "$LOCAL_USER_ID" -g joinmarket joinmarket \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/
COPY yg-wrapper.sh /usr/local/bin/
COPY joinmarket.cfg /tmp/joinmarket.cfg

STOPSIGNAL SIGINT

ENTRYPOINT [ "entrypoint.sh" ]
