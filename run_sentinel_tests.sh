#!/usr/bin/env bash
set -e
find . -name \*.pyc -delete
rm -rf .tox
if [ "$TOX_ENV" = "" ]
then
   TOX_ENV='py27-django18-redis'
fi
cd /sorl-thumbnail
env | sort
tox -e $TOX_ENV
flake8 --show-source sorl/
