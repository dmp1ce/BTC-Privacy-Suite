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
      - ${_HOST_TOR_DATA:?}:${_GUEST_TOR_DATA:?}:ro
      - ${_HOST_TOR_CONFIG:?}:${_GUEST_TOR_CONFIG:?}:ro
      - ${_HOST_LND:?}:/home/lit/.lnd:ro
      - ${_HOST_LIT_LIT:?}:${_GUEST_LIT_LIT:?}
      - ${_HOST_LIT_FARADAY:?}:${_GUEST_LIT_FARADAY:?}
      - ${_HOST_LIT_LOOP:?}:${_GUEST_LIT_LOOP:?}
      - ${_HOST_LIT_POOL:?}:${_GUEST_LIT_POOL:?}
    command: litd
    env_file:
      - .env
      - env/lit.env

  tor:
    ports:
      # Terminal web interface
      - "8443:8443"
