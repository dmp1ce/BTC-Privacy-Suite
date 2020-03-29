FROM nginx:alpine
LABEL maintainer="David Parrish <daveparrish@tutanota.com>"

# Add openssl for creating self-signed certificate
RUN apk --no-cache --no-progress add openssl=~1

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /root/entrypoint.sh

ENTRYPOINT [ "/root/entrypoint.sh" ]
