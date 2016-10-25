#!/usr/bin/env bash
SORL_THUMBNAIL_CONTAINER=`docker ps -aqf "name=sorl-thumbnail-xenial-redis30"`
docker exec -it $SORL_THUMBNAIL_CONTAINER bash
