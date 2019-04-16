FROM ruimarinho/bitcoin-core:0.17-alpine

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

# Set the expected local user id
# for shared group to access tor cookie
RUN apk -U --no-progress update && apk -U --no-progress upgrade && \
  apk -U --no-progress add -u shadow gettext && \
  groupadd -g "$LOCAL_GROUP_ID" bitcoin && \
  usermod -u "$LOCAL_USER_ID" -g bitcoin bitcoin

COPY entrypoint.sh /root/entrypoint.sh
COPY bitcoin.conf /tmp/bitcoin.conf
ENTRYPOINT [ "/root/entrypoint.sh" ]
CMD ["bitcoind"]
