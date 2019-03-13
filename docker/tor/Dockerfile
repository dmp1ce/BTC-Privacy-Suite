FROM connectical/tor

USER root
ARG LOCAL_USER_ID=9999
ENV TOR_DATA=/var/lib/tor

# Add useradd and usermod
# Create user account (UID will be changed in entrypoint script)
RUN apk -U --no-progress update && apk -U --no-progress upgrade && \
  apk -U --no-progress add -u shadow sudo && \
  useradd -u $LOCAL_USER_ID --shell /bin/sh -m alice && \
  usermod -g alice tor

COPY entrypoint.sh /root/entrypoint.sh

ENTRYPOINT [ "/root/entrypoint.sh" ]
