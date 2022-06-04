#!/bin/sh
set -e

: ${GUNICORN_PID_FILE=/tmp/gunicorn.pid}

kill -HUP `cat $GUNICORN_PID_FILE`
exit 0