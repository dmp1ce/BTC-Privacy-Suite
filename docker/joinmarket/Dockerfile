FROM join-market

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

# Make working directory
RUN mkdir -p /jm/clientserver/working

# Set the expected local user id
# for shared group to access tor cookie
# hadolint ignore=DL3002
USER root
# hadolint ignore=DL3008
RUN apt-get update \
  && apt-get install -yq --no-install-recommends gettext-base \
  && usermod -u "$LOCAL_USER_ID" joinmarket \
  && usermod -u "$LOCAL_USER_ID" -g joinmarket joinmarket \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/
COPY joinmarket.cfg /tmp/joinmarket.cfg

ENTRYPOINT [ "entrypoint.sh" ]
