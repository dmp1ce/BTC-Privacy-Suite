---
version: '3.8'

services:
  dockerproxy:
    privileged: true
    image: tecnativa/docker-socket-proxy
    network_mode: service:tor
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"

  tor:
    expose:
      - 2375
