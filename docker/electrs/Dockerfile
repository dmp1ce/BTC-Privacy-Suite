FROM dmp1ce/electrs:0.9.2
LABEL maintainer="David Parrish <daveparrish@tutanota.com>"

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

RUN mkdir -p /home/user/.electrs

# Set the expected local user id
# for shared group to access tor cookie
# hadolint ignore=DL3002
USER root
RUN apt-get update \
  && apt-get install --no-install-recommends -yq \
     sudo=1.* gettext-base=0.* \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && groupadd -g "$LOCAL_GROUP_ID" user \
  && useradd -u "$LOCAL_USER_ID" -g user user

COPY entrypoint.sh /root/entrypoint.sh
COPY electrs.toml /tmp/electrs.toml

ENTRYPOINT [ "/root/entrypoint.sh" ]
