#!/usr/bin/env bash
set -e
SORL_THUMBNAIL_CONTAINER=`docker ps -aqf "name=sorl-thumbnail"`
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"

