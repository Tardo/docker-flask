#!/bin/sh
set -e

. /env_secrets_expand.sh

cd /usr/src/app
poetry install $POETRY_INSTALL_ARGS
poetry run npm install $NPM_INSTALL_ARGS
poetry run supervisord
exit 0
