version: '3.8'

services:
  ofelia:
    image: mcuadros/ofelia:latest
    depends_on:
      - bos
    command: daemon --docker
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
    
  bos:
    build:
      context: docker/bos
    restart: unless-stopped
    network_mode: service:tor
    depends_on:
      - tor
      - lnd
    volumes:
      - ${_SRC_TOR_DATA:?}:${_DST_TOR_DATA:?}:ro
      - ${_SRC_TOR_CONFIG:?}:${_DST_TOR_CONFIG:?}:ro
      - ${_SRC_LND:?}:/home/node/.lnd:ro
      - .data/bos/data:/home/node/.data

    command: cron
    env_file:
      - .env
      - env/lnd.env
    labels:
      ofelia.enabled: "true"
      ofelia.job-exec.bos-unlock.schedule: "@every 20m"
      ofelia.job-exec.bos-unlock.command: "sudo -u node bos unlock .data/unlock_file"
