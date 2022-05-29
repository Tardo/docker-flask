# DOCKER FLASK
---

This docker image is prepared to run Flask applications using gunicorn (gevent). In addition, this image provides poetry and npm with rollup and postcss.


#### Mount points of interest

| MOUNT POINT | DESCRIPTION |
|----------|---------|
| /usr/src/app | Here is where your flask application must be | 
| /root/.cache | Here is where poetry stores the packages |
| /root/.npm | Here is where npm stores the packages |

#### About your flask configuration

Threaded mode is handled by gunicorn so you must disable `threaded` mode in the configuration of your flask application.

#### Shared memory

gunicorn workers uses the shared memory for temporal storage. To increase the docker shared memory available see the documentation about `shm-size` option.

#### Customize gunicorn startup

| ENV. VAR | DEFAULT |
|----------|---------|
| $GUNICORN_TIMEOUT | 200 | 
| $GUNICORN_KEEP_ALIVE | 5 |
| $GUNICORN_MAX_REQUESTS | 10000 |
| $GUNICORN_FLASK_APP | run:app |

#### Customize poetry and npm project installation process

| ENV. VAR | DEFAULT | Example |
|----------|---------|---------|
| $POETRY_INSTALL_ARGS | Empty | --no-dev  | 
| $NPM_INSTALL_ARGS | Empty | --no-save --omit=dev |

#### Recommended env. variables

| ENV. VAR | DEFAULT | VALUES |
|----------|---------|--------|
| $FLASK_ENV | development | production, development, testing | 
| $NODE_ENV | development | production, development, testing |
| $POETRY_NO_DEV | False | True, False |

#### Aditional Information

This image supports the expansion of secrets with the syntax.: `DOCKER-SECRET->secret_name`


