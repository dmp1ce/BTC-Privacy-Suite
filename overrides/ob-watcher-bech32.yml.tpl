version: '3.8'

services:
  ob-watcher-bech32:
    build:
      context: docker/joinmarket
    restart: unless-stopped
    network_mode: service:tor
    depends_on:
      - joinmarketd-bech32
      - tor
      - bitcoin
    volumes:
      - ${_HOST_TOR_DATA:?}:${_GUEST_TOR_DATA:?}:ro
      - ${_HOST_TOR_CONFIG:?}:${_GUEST_TOR_CONFIG:?}:ro
      - ./.data/joinmarket_bech32:${_GUEST_JOINMARKET:?}
    command: python3 obwatch/ob-watcher.py -p 62501 -H 0.0.0.0
    tty: true
    env_file:
      - .env
      - env/bitcoin.env

  tor:
    ports:
      # Web service
      - "62501:62501"
