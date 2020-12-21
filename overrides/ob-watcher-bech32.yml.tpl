version: '3.7'

x-tor-data-ro: &tor-data-ro "./tor_data:/var/lib/tor:ro"
x-tor-config-ro: &tor-config-ro "./tor_config:/etc/tor:ro"
x-rpc-settings: &rpc-settings
  RPCPASSWORD:
  RPCUSER:

services:
  ob-watcher-bech32:
    build:
      context: docker/joinmarket
    restart: always
    network_mode: service:tor
    depends_on:
      - joinmarketd-bech32
      - tor
      - bitcoin
    volumes:
      - *tor-data-ro
      - *tor-config-ro
      - ./joinmarket_bech32_data:/home/joinmarket/.joinmarket
    command: python3 obwatch/ob-watcher.py -p 62501 -H 0.0.0.0
    tty: true
    environment:
      <<: *rpc-settings

  tor:
    ports:
      # Web service
      - "62501:62501"
