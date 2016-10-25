#!/usr/bin/env bash
#set -e
SORL_THUMBNAIL_CONTAINER=`docker ps -aqf "name=sorl-thumbnail"`
# Py27
TOX_ENV="py27-django18-pil"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py27-django18-imagemagick"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py27-django18-graphicsmagick"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py27-django18-redis"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py27-django18-sentinel"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py27-django18-wand"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py27-django18-pgmagick"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py27-django18-dbm"
# Py34
TOX_ENV="py34-django18-pil"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py34-django18-imagemagick"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py34-django18-graphicsmagick"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py34-django18-redis"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py34-django18-sentinel"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py34-django18-wand"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py34-django18-pgmagick"
docker exec -t $SORL_THUMBNAIL_CONTAINER /bin/bash -c \
    "export TOX_ENV=$TOX_ENV && export LANG=en_US.UTF-8 && cd /sorl-thumbnail && bash run_sentinel_tests.sh"
TOX_ENV="py34-django18-dbm"
