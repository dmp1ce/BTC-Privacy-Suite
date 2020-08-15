FROM dmp1ce/joinmarket:0.6.3.1

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

# Set the expected local user id
# for shared group to access tor cookie
# hadolint ignore=DL3002
USER root
RUN apt-get update \
  && apt-get install -yq --no-install-recommends gettext-base=0* python3-nacl=1* dumb-init=1* \
  && usermod -u "$LOCAL_USER_ID" joinmarket \
  && usermod -u "$LOCAL_USER_ID" -g joinmarket joinmarket \
  && ln -s /home/joinmarket/.joinmarket/commitmentlist /jm/clientserver/scripts/commitmentlist \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/
COPY yg-wrapper.sh /usr/local/bin/
COPY joinmarket.cfg /tmp/joinmarket.cfg

STOPSIGNAL SIGINT

# Use dumb-init to forward signals to subshells in wrapper
ENTRYPOINT ["/usr/bin/dumb-init", "-v", "--", "entrypoint.sh"]
