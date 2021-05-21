version: '3.8'

services:
  bitcoin:
    build:
      context: docker/bitcoin
    restart: always
    network_mode: service:tor
    depends_on:
      - tor
    volumes:
      - ${_HOST_TOR_DATA:?}:${_GUEST_TOR_DATA:?}:ro
      - ${_HOST_TOR_CONFIG:?}:${_GUEST_TOR_CONFIG:?}:ro
      - ${_HOST_BITCOIN:?}:${_GUEST_BITCOIN:?}
    env_file:
      - .env
      - env/bitcoin.env
