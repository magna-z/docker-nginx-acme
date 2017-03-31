#!/bin/sh

set -e

crond -b -L /var/log/crond.log

nginx -g "daemon off;"
