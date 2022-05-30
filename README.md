# DOCKER FLASK
---

This docker image is prepared to run Flask applications using gunicorn. In addition, this image provides poetry and npm with rollup and postcss.

#### Important notes

- This image is for Flask projects using poetry and npm.
- This image doesn't come with gunicorn installed, this must be provided by your poetry configuration.
- You probably need to change the `GUNICORN_FLASK_APP` environment variable to adjust it to how your project is defined.

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
| $GUNICORN_WORKER_CLASS | gevent |
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

#### SQLAchemy problems?

You must adjust how SQAlchemy handles the connection pool to work correctly with gunicorn.

The simplest method is to disable the connection pool. This means that they are not recycled and a new connection is always opened:
```python
from sqlalchemy.pool import NullPool

db = SQLAlchemy(None, engine_options={'poolclass': NullPool})
```

More info. here: https://docs.sqlalchemy.org/en/13/core/pooling.html#using-connection-pools-with-multiprocessing-or-os-fork

#### Execute Flask CLI commands

A safe way to do this is:
```bash
docker-compose stop <FLASK_SERVICE_NAME>
docker-compose run --rm --entrypoint="" <FLASK_SERVICE_NAME> inv_flask <COMMAND>
docker-compose start <FLASK_SERVICE_NAME>
```
** Replace `<FLASK_SERVICE_NAME>` and `<COMMAND>`

#### Aditional Information

This image supports the expansion of secrets with the syntax.: `DOCKER-SECRET->secret_name`


