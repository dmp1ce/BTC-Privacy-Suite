# version 0.9.9 https://hub.docker.com/layers/dmp1ce/joinmarket/0.9.9/images/sha256-5830cc47cc1edf9e3795a2bdc6af5e0861d5fb1090f0a29aba2c0a0b99f0954d?context=repo
FROM dmp1ce/joinmarket@sha256:5830cc47cc1edf9e3795a2bdc6af5e0861d5fb1090f0a29aba2c0a0b99f0954d

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

# Set the expected local user id
# for shared group to access tor cookie
# hadolint ignore=DL3002
USER root
RUN apt-get update \
  && apt-get install -yq --no-install-recommends gettext-base=0* python3-nacl=1* tini=0* \
  && usermod -u "$LOCAL_USER_ID" joinmarket \
  && usermod -u "$LOCAL_USER_ID" -g joinmarket joinmarket \
  && ln -s /home/joinmarket/.joinmarket/commitmentlist /jm/clientserver/scripts/commitmentlist \
  && echo "Symlink tumber logs into data volume area" \
  && echo "This is an issue with upstream. Data directories shouldn't be in script directory" \
  && ln -s /home/joinmarket/.joinmarket/tumbler_logs /jm/clientserver/scripts/logs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/
COPY yg-wrapper.sh /usr/local/bin/
COPY joinmarket.cfg /tmp/joinmarket.cfg

STOPSIGNAL SIGINT

# Use tini to forward signals to subshells in wrapper
ENTRYPOINT ["/usr/bin/tini", "-v", "-g", "--", "entrypoint.sh"]
