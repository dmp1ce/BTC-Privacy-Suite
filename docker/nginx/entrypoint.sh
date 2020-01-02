#!/bin/sh

KEYS_DIR=/root/keys
ELECTRS_KEY=$KEYS_DIR/electrs.key
ELECTRS_CERT=$KEYS_DIR/electrs.crt

mkdir -p /root/keys

log() {
    echo "$(date +"%Y-%m-%dT%H:%M:%SZ"):" "$@"
}

# Delete certificates if within one year of expiring,
# so they can be recreated.
if [ -f $ELECTRS_CERT ] && ! openssl x509 -noout -checkend 31536000 1>/dev/null < $ELECTRS_CERT; then
    log "Less than one year until certificate expires for Electrum TLS."
    log "Removing old certificate."
    rm $ELECTRS_CERT
    rm $ELECTRS_KEY
fi

# Create certificate for 10 years,
# so we don't really have to worry about expiring certificates very often
if [ ! -f $ELECTRS_KEY ] || [ ! -f $ELECTRS_CERT ]; then
    log "Creating new certificate for Electrum TLS."
    log "Certificate expires in 3650 days."
    openssl req -nodes -x509 -days 3650 -newkey rsa:4096 \
            -keyout "$ELECTRS_KEY"\
            -out "$ELECTRS_CERT"\
            -subj '/CN=localhost'
fi

nginx -g "daemon off;"
