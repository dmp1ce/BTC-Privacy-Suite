version: '3.8'

x-jm-settings: &jm-settings

  # Wrapper script settings
  JM_NATIVE_SEGWIT: "true"
  JM_BITCOIN_COOKIE_FILE: "/home/joinmarket/.bitcoin/.cookie"

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
      - ${_HOST_BITCOIN:?}:/home/joinmarket/.bitcoin:ro
    command: python3 joinmarketd.py
    tty: true
    env_file:
      - .env
      - env/bitcoin.env
    environment:
      <<: *jm-settings
