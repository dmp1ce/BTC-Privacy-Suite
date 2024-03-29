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
      - bos
  bos:
    build:
      context: docker/bos
    restart: unless-stopped
    network_mode: service:tor
    depends_on:
      - tor
      - lnd
    volumes:
      - ${_HOST_TOR_DATA:?}:${_GUEST_TOR_DATA:?}:ro
      - ${_HOST_TOR_CONFIG:?}:${_GUEST_TOR_CONFIG:?}:ro
      - ${_HOST_LND:?}:/home/node/.lnd:ro
      - .data/bos/data:/home/node/.data

    command: cron
    env_file:
      - .env
      - env/lnd.env
    labels:
      ofelia.enabled: "true"
      ofelia.job-exec.bos-unlock.schedule: "@every 20m"
      ofelia.job-exec.bos-unlock.command:
        "sudo -u node bos unlock .data/unlock_file"
