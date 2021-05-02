version: '3.7'

services:
  lnd:
    build:
      context: docker/lnd
    restart: always
    network_mode: service:tor
    depends_on:
      - tor
      - bitcoin
    volumes:
      - ${_SRC_TOR_DATA:?}:${_DST_TOR_DATA:?}:ro
      - ${_SRC_TOR_CONFIG:?}:${_DST_TOR_CONFIG:?}:ro
      - ${_SRC_LND:?}:${_DST_LND:?}
    command: lnd
    env_file:
      - .env
      - env/bitcoin.env
      - env/lnd.env

  tor:
    ports:
      # LND Rest
      - "8080:8080"
      # LND RPC
      - "10009:10009"
