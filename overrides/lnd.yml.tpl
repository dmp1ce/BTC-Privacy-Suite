version: '3.8'

services:
  lnd:
    build:
      context: docker/lnd
    restart: always
    network_mode: service:tor
    depends_on:
      - tor
    volumes:
      - ${_HOST_TOR_DATA:?}:${_GUEST_TOR_DATA:?}:ro
      - ${_HOST_TOR_CONFIG:?}:${_GUEST_TOR_CONFIG:?}:ro
      - ${_HOST_LND:?}:${_GUEST_LND:?}
    command: lnd
    env_file:
      - env/bitcoin.env
      - env/lnd.env
    environment:
      LOCAL_USER_ID: ${LOCAL_USER_ID:?}
      LOCAL_GROUP_ID: ${LOCAL_GROUP_ID:?}
      LND_RPC_PORT: ${_GUEST_LND_RPC_PORT:?}
      LND_REST_PORT: ${_GUEST_LND_REST_PORT:?}

  tor:
    ports:
      # LND Rest
      - "${_HOST_LND_REST_PORT:?}:${_GUEST_LND_REST_PORT:?}"
      # LND RPC
      - "${_HOST_LND_RPC_PORT:?}:${_GUEST_LND_RPC_PORT:?}"
