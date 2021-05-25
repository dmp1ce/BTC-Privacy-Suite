version: '3.8'

services:
  dockerproxy:
    environment:
      CONTAINERS: 1
    image: tecnativa/docker-socket-proxy
    network_mode: service:tor
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
  traefik:
    depends_on:
      - dockerproxy
    build:
      context: docker/traefik
    network_mode: service:tor
    restart: always
    volumes:
      - ./.data/traefik:/home/traefik/data
    command: traefik
    environment:
      LOCAL_USER_ID: ${LOCAL_USER_ID:?}
      LOCAL_GROUP_ID: ${LOCAL_GROUP_ID:?}

  tor:
    ports:
      - "80:80"
      - "443:443"
    expose:
      - 2375
