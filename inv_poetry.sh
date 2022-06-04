#!/bin/sh
set -e

. /env_secrets_expand.sh

cd /usr/src/app
poetry run $@
exit 0