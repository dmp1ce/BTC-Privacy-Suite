version: '3.8'

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
      - ${_HOST_TOR_DATA:?}:${_GUEST_TOR_DATA:?}:ro
      - ${_HOST_TOR_CONFIG:?}:${_GUEST_TOR_CONFIG:?}:ro
      - ${_HOST_JOINMARKET:?}:${_GUEST_JOINMARKET:?}
    command: python3 joinmarketd.py
    tty: true
    env_file:
      - .env
      - env/bitcoin.env
