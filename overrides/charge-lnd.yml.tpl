---
version: '3.8'

services:
  dockerproxy:
    environment:
      CONTAINERS: 1
      POST: 1
      EXEC: 1
  ofelia:
    depends_on:
      - charge-lnd
  charge-lnd:
    build:
      context: docker/charge-lnd
    restart: unless-stopped
    network_mode: service:tor
    depends_on:
      - tor
      - lnd
    volumes:
      - ${_HOST_TOR_DATA:?}:${_GUEST_TOR_DATA:?}:ro
      - ${_HOST_TOR_CONFIG:?}:${_GUEST_TOR_CONFIG:?}:ro
      - ${_HOST_LND:?}:/home/charge/.lnd:ro
      - .data/charge-lnd/data:/app
    env_file:
      - .env
      - env/lnd.env
      - env/bitcoin.env
    labels:
      ofelia.enabled: "true"
      ofelia.job-exec.charge-lnd.schedule: "@every 1h"
      ofelia.job-exec.charge-lnd.use: "charge"
      ofelia.job-exec.charge-lnd.command:
        "/home/charge/charge-lnd-wrapper.bash"
