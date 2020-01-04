version: '3.7'

services:
  joinmarket-yield-generator-basic:
    build:
      context: docker/joinmarket
    restart: always
    network_mode: service:tor
    depends_on:
      - joinmarket
      - tor
      - bitcoin
    volumes:
      - *tor-data-ro
      - *tor-config-ro
      - ./joinmarket_data:/jm/clientserver/working
    command: echo -n 'WALLET PASSWORD' | python yield-generator-basic.py wallet.jmdat --wallet-password-stdin
    environment:
      <<: *rpc-settings
