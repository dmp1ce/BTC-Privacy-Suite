version: '3.7'

x-tor-data-ro: &tor-data-ro "./tor_data:/var/lib/tor:ro"
x-tor-config-ro: &tor-config-ro "./tor_config:/etc/tor:ro"
x-rpc-settings: &rpc-settings
  RPCPASSWORD:
  RPCUSER:
x-network-settings: &network-settings
  TESTNET_NUM:
  ELECTRS_NETWORK:

services:
  tor:
    ports:
      - "50001:50001"
      - "50002:50002"
      - "60001:60001"
      - "60002:60002"

  electrs:
    build:
      context: docker/electrs
    restart: always
    network_mode: service:tor
    depends_on:
      - tor
      - bitcoin
    volumes:
      - *tor-data-ro
      - *tor-config-ro
      - ./bitcoin_data:/home/user/.bitcoin:ro
      - ./electrs_data:/home/user/.electrs
    command: /usr/local/cargo/bin/electrs -vvvv --timestamp --db-dir /home/user/.electrs/db
    environment:
      <<: *rpc-settings
      <<: *network-settings

  # Use Nginx to enable TLS connections to electrs
  nginx:
    build:
      context: docker/nginx
    restart: always
    network_mode: service:tor
    depends_on:
      - tor
      - electrs
    volumes:
      - ./nginx_keys:/root/keys
