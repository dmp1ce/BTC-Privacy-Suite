FROM ruimarinho/bitcoin-core:24-alpine
LABEL maintainer="David Parrish <daveparrish@tutanota.com>"

ARG LOCAL_USER_ID=9999
ARG LOCAL_GROUP_ID=9999

# Set the expected local user id
# for shared group to access tor cookie
RUN apk --no-cache --no-progress add shadow=~4 gettext=~0.21 && \
  groupmod -g "$LOCAL_GROUP_ID" bitcoin && \
  usermod -u "$LOCAL_USER_ID" -g bitcoin bitcoin

COPY entrypoint.sh /root/entrypoint.sh
COPY bitcoin.conf /tmp/bitcoin.conf
ENTRYPOINT [ "/root/entrypoint.sh" ]
CMD ["bitcoind"]
