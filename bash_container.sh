#!/usr/bin/env bash
SORL_THUMBNAIL_CONTAINER=`docker ps -aqf "name=sorl-thumbnail"`
docker exec -it $SORL_THUMBNAIL_CONTAINER bash
