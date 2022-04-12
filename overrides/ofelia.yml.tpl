---
version: '3.8'

services:
  ofelia:
    image: mcuadros/ofelia:latest
    depends_on:
      - dockerproxy
    command: daemon --docker
    environment:
      DOCKER_HOST: tcp://tor:2375
