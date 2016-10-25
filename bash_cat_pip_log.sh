#!/usr/bin/env bash
SORL_THUMBNAIL_CONTAINER=`docker ps -aqf "name=sorl-thumbnail"`
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "cat /root/.pip/pip.log"
