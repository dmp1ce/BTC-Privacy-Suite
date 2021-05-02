version: '3.7'

services:
  joinmarketd:
    build:
      context: docker/joinmarket
    restart: always
    network_mode: service:tor
    depends_on:
      - tor
      - bitcoin
    volumes:
      - ${_SRC_TOR_DATA:?}:${_DST_TOR_DATA:?}:ro
      - ${_SRC_TOR_CONFIG:?}:${_DST_TOR_CONFIG:?}:ro
      - ${_SRC_JOINMARKET:?}:${_DST_JOINMARKET:?}
    command: python3 joinmarketd.py
    tty: true
    env_file:
      - .env
      - env/bitcoin.env
