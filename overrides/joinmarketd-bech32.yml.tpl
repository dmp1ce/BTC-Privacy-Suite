version: '3.8'

services:
  joinmarketd-bech32:
    build:
      context: docker/joinmarket
    restart: always
    network_mode: service:tor
    depends_on:
      - tor
      - bitcoin
    volumes:
      - ${_HOST_TOR_DATA:?}:${_GUEST_TOR_DATA:?}:ro
      - ${_HOST_TOR_CONFIG:?}:${_GUEST_TOR_CONFIG:?}:ro
      - ./.data/joinmarket_bech32:${_GUEST_JOINMARKET:?}
    command: python3 joinmarketd.py 27173
    tty: true
    env_file:
      - .env
      - env/bitcoin.env
