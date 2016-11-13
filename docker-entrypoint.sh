#!/bin/sh

set -e

# Start Cron in background
crond

# Start Nginx in foreground
nginx -g "daemon off;"
