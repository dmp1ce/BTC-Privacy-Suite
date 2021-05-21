version: '3.8'

services:
  sphinx-chat:
    build:
      context: docker/sphinx-chat
    restart: unless-stopped
    network_mode: service:tor
    depends_on:
      - tor
      - lnd
    volumes:
      - ${_HOST_TOR_DATA:?}:${_GUEST_TOR_DATA:?}:ro
      - ${_HOST_TOR_CONFIG:?}:${_GUEST_TOR_CONFIG:?}:ro
      - ${_HOST_LND:?}:/relay/.lnd:ro
      - .data/sphinx-chat:/relay/.data

    env_file:
      - env/bitcoin.env
      - env/lnd.env
      - env/sphinx-chat.env

    environment:
      LOCAL_USER_ID: ${LOCAL_USER_ID:?}
      LOCAL_GROUP_ID: ${LOCAL_GROUP_ID:?}
      LND_RPC_PORT: ${_GUEST_LND_RPC_PORT:?}
      LND_REST_PORT: ${_GUEST_LND_REST_PORT:?}
      # Override upstream PORT setting
      PORT: ${_SPHINX_CHAT_PORT_GUEST:?}

  tor:
    ports:
      # Sphinx-Chat web
      - "${_SPHINX_CHAT_PORT_HOST:?}:${_SPHINX_CHAT_PORT_GUEST:?}"
