version: '3.8'

services:
  tor:
    ports:
      - "50001:50001"
      - "50002:50002"
      - "60001:60001"
      - "60002:60002"

  electrs:
    build:
      context: docker/electrs
    restart: always
    network_mode: service:tor
    depends_on:
      - tor
      - bitcoin
    volumes:
      - ${_HOST_TOR_DATA:?}:${_GUEST_TOR_DATA:?}:ro
      - ${_HOST_TOR_CONFIG:?}:${_GUEST_TOR_CONFIG:?}:ro
      - ${_HOST_BITCOIN:?}:/home/user/.bitcoin:ro
      - ${_HOST_ELECTRS_DATA:?}:${_GUEST_ELECTRS_DATA:?}
    command: /usr/bin/electrs --timestamp --db-dir /home/user/.electrs/db
    env_file:
      - .env
      - env/bitcoin.env

  # Use Nginx to enable TLS connections to electrs
  nginx:
    build:
      context: docker/nginx
    restart: always
    network_mode: service:tor
    depends_on:
      - tor
      - electrs
    volumes:
      - ${_HOST_ELECTRS_NGINX:?}:${_GUEST_ELECTRS_NGINX:?}
