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
      - ${_HOST_TOR_DATA:?}:${_GUEST_TOR_DATA:?}:ro
      - ${_HOST_TOR_CONFIG:?}:${_GUEST_TOR_CONFIG:?}:ro
      - ${_HOST_LND:?}:/home/node/.lnd:ro
      - ${_HOST_RTL:?}:${_GUEST_RTL:?}
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
