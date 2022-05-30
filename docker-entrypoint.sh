#!/bin/sh
set -e

: ${GUNICORN_TIMEOUT=200}
: ${GUNICORN_WORKER_CLASS=gevent}
: ${GUNICORN_KEEP_ALIVE=5}
: ${GUNICORN_MAX_REQUESTS=10000}
: ${GUNICORN_FLASK_APP=run:app}

. /env_secrets_expand.sh

cd /usr/src/app
poetry install $POETRY_INSTALL_ARGS
poetry run npm install $NPM_INSTALL_ARGS
poetry run gunicorn --worker-tmp-dir /dev/shm --timeout $GUNICORN_TIMEOUT -k $GUNICORN_WORKER_CLASS --keep-alive $GUNICORN_KEEP_ALIVE --max-requests $GUNICORN_MAX_REQUESTS --preload $GUNICORN_FLASK_APP
exit 0
