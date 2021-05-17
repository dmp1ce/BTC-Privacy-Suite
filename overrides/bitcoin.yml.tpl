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
      - ${_SRC_TOR_DATA:?}:${_DST_TOR_DATA:?}:ro
      - ${_SRC_TOR_CONFIG:?}:${_DST_TOR_CONFIG:?}:ro
      - ${_SRC_BITCOIN:?}:${_DST_BITCOIN:?}
    env_file:
      - .env
      - env/bitcoin.env
