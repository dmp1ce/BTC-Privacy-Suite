#!/bin/sh

KEYS_DIR=/root/keys
ELECTRS_KEY=$KEYS_DIR/electrs.key
ELECTRS_CERT=$KEYS_DIR/electrs.crt

mkdir -p /root/keys

log() {
    echo "$(date +"%Y-%m-%dT%H:%M:%SZ"):" "$@"
}

# Generate key
if [ ! -f $ELECTRS_KEY ]; then
    # https://wiki.archlinux.org/index.php/OpenSSL#Usage
    log "Generating key for Electrum TLS"
    openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -out $ELECTRS_KEY
fi

# If the cert doesn't exist or is going to expire in 10 years then regenerate it for 100 years
if [ ! -f $ELECTRS_CERT ] || ! openssl x509 -noout -checkend 315360000 1>/dev/null < $ELECTRS_CERT; then
    log "Creating new certificate (expires in 36600 days) for Electrum TLS."
    openssl req -key $ELECTRS_KEY -x509 -new -days 36600 -subj '/CN=localhost' -out $ELECTRS_CERT
fi

nginx -g "daemon off;"
