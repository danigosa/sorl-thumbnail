#!/usr/bin/env bash
service redis-server start  # Redis local server
/usr/bin/tail -f /dev/null  # keeps container running

