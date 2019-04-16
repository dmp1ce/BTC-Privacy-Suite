#!/bin/bash

docker-compose build --build-arg LOCAL_USER_ID="$(id -u "$USER")"
