version: '3.8'

services:
  lit:
    build:
      context: docker/lnd
      dockerfile: lit.Dockerfile
    restart: always
    network_mode: service:tor
    depends_on:
      - tor
      - bitcoin
      - lnd
    volumes:
      - ./tor_data:/var/lib/tor:ro
      - ./tor_config:/etc/tor:ro
      - ./lit_data/lit:/home/lit/.lit
      - ./lit_data/faraday:/home/lit/.faraday
      - ./lit_data/loop:/home/lit/.loop
      - ./lit_data/pool:/home/lit/.pool
      - ./lnd_data:/home/lit/.lnd:ro
    command: litd
    env_file:
      - .env
      - env/lit.env

  tor:
    ports:
      # Terminal web interface
      - "8443:8443"
