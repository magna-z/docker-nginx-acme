#!/bin/sh

set -e

# Start Cron in background
crond -b -L /var/log/crond.log

# Start Nginx in foreground
nginx -g "daemon off;"
