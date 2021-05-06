version: '3.8'

services:
  rtl:
    build:
      context: docker/rtl
    restart: unless-stopped
    network_mode: service:tor
    depends_on:
      - tor
      - lnd
    volumes:
      - ${_SRC_TOR_DATA:?}:${_DST_TOR_DATA:?}:ro
      - ${_SRC_TOR_CONFIG:?}:${_DST_TOR_CONFIG:?}:ro
      - ${_SRC_LND:?}:/home/node/.lnd:ro
      - ${_SRC_RTL:?}:${_DST_RTL:?}
    command: node rtl
    env_file:
      - .env
      - env/bitcoin.env
      - env/lnd.env
      - env/rtl.env

  tor:
    ports:
      # Web interface
      - "3000:3000"
