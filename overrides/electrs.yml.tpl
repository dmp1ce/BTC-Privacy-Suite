version: '3.7'

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
      - ${_SRC_TOR_DATA:?}:${_DST_TOR_DATA:?}:ro
      - ${_SRC_TOR_CONFIG:?}:${_DST_TOR_CONFIG:?}:ro
      - ${_SRC_BITCOIN:?}:/home/user/.bitcoin:ro
      - ${_SRC_ELECTRS_DATA:?}:${_DST_ELECTRS_DATA:?}
    command: /usr/local/cargo/bin/electrs -vvvv --timestamp --db-dir /home/user/.electrs/db
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
      - ${_SRC_ELECTRS_NGINX:?}:${_DST_ELECTRS_NGINX:?}
