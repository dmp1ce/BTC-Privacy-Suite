version: '3.7'

x-tor-data-ro: &tor-data-ro "./tor_data:/var/lib/tor:ro"
x-tor-config-ro: &tor-config-ro "./tor_config:/etc/tor:ro"
x-rpc-settings: &rpc-settings
  RPCPASSWORD:
  RPCUSER:

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
      - *tor-data-ro
      - *tor-config-ro
      - ./joinmarket_data:/home/joinmarket/.joinmarket
    command: python3 joinmarketd.py
    environment:
      <<: *rpc-settings
