FROM dmp1ce/electrs:0.8.1

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

RUN mkdir -p /home/user/.electrs

# Set the expected local user id
# for shared group to access tor cookie
USER root
RUN apt install -yq sudo gettext-base && \
  groupadd -g "$LOCAL_GROUP_ID" user && \
  usermod -u "$LOCAL_USER_ID" -g user user

COPY entrypoint.sh /root/entrypoint.sh
COPY electrs.toml /tmp/electrs.toml

ENTRYPOINT [ "/root/entrypoint.sh" ]
