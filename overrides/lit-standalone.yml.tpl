version: '3.8'

services:
  lit:
    build:
      context: docker/lnd
      dockerfile: lit.Dockerfile
    restart: always
    network_mode: service:tor
    depends_on:
      - tor
      - bitcoin
      - lnd
    volumes:
      - ${_SRC_TOR_DATA:?}:${_DST_TOR_DATA:?}:ro
      - ${_SRC_TOR_CONFIG:?}:${_DST_TOR_CONFIG:?}:ro
      - ${_SRC_LND:?}:/home/lit/.lnd:ro
      - ${_SRC_LIT_LIT:?}:${_DST_LIT_LIT:?}
      - ${_SRC_LIT_FARADAY:?}:${_DST_LIT_FARADAY:?}
      - ${_SRC_LIT_LOOP:?}:${_DST_LIT_LOOP:?}
      - ${_SRC_LIT_POOL:?}:${_DST_LIT_POOL:?}
    command: litd
    env_file:
      - .env
      - env/lit.env

  tor:
    ports:
      # Terminal web interface
      - "8443:8443"
