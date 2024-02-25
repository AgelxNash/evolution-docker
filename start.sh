#!/usr/bin/env bash

docker-compose build --progress=plain
docker-compose up --remove-orphans