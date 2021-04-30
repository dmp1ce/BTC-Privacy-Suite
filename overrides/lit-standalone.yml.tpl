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
      - ./lnd_data:/home/lit/.lnd:ro
      - ./.data/lit/lit:/home/lit/.lit
      - ./.data/lit/faraday:/home/lit/.faraday
      - ./.data/lit/loop:/home/lit/.loop
      - ./.data/lit/pool:/home/lit/.pool
    command: litd
    env_file:
      - .env
      - env/lit.env

  tor:
    ports:
      # Terminal web interface
      - "8443:8443"
