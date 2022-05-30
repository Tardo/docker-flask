#!/bin/sh
set -e

cd /usr/src/app
poetry run flask $@
exit 0