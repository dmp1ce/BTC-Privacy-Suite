version: '3.7'

services:
  ob-watcher:
    build:
      context: docker/joinmarket
    restart: unless-stopped
    network_mode: service:tor
    depends_on:
      - joinmarketd
      - tor
      - bitcoin
    volumes:
      - ${_SRC_TOR_DATA:?}:${_DST_TOR_DATA:?}:ro
      - ${_SRC_TOR_CONFIG:?}:${_DST_TOR_CONFIG:?}:ro
      - ${_SRC_JOINMARKET:?}:${_DST_JOINMARKET:?}
    command: python3 obwatch/ob-watcher.py -H 0.0.0.0
    tty: true
    env_file:
      - .env
      - env/bitcoin.env

  tor:
    ports:
      # Web service
      - "62601:62601"
