FROM nginx:alpine

# Add openssl for creating self-signed certificate
RUN apk -U --no-progress update && apk -U --no-progress upgrade && \
  apk -U --no-progress add -u openssl

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /root/entrypoint.sh

ENTRYPOINT [ "/root/entrypoint.sh" ]
