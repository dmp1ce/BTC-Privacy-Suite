version: '3.7'

x-tor-data-ro: &tor-data-ro "./tor_data:/var/lib/tor:ro"
x-tor-config-ro: &tor-config-ro "./tor_config:/etc/tor:ro"
x-rpc-settings: &rpc-settings
  RPCPASSWORD:
  RPCUSER:
x-lnd-settings: &lnd-settings
  LND_ALIAS:
  LND_COLOR:
x-network-settings: &network-settings
  TESTNET_NUM:
  ELECTRS_NETWORK:

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
      - *tor-data-ro
      - *tor-config-ro
      - ./lnd_data:/home/lnd/.lnd
    command: lnd
    environment:
      <<: *lnd-settings
      <<: *rpc-settings
      <<: *network-settings
