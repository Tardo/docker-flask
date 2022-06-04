# DOCKER FLASK
---

This docker image is prepared to run Flask applications using gunicorn. In addition, this image provides poetry and npm with rollup and postcss.

#### Important notes

- This image is for Flask projects using poetry, supervisor and npm.
- This image doesn't come with gunicorn and supervisor installed, this must be provided by your poetry configuration.

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
| $GUNICORN_PID_FILE | /tmp/gunicorn.pid | --path-- |

#### SQLAchemy problems?

You must adjust how SQAlchemy handles the connection pool to work correctly with gunicorn.

The simplest method is to disable the connection pool. This means that they are not recycled and a new connection is always opened:
```python
from sqlalchemy.pool import NullPool

db = SQLAlchemy(None, engine_options={'poolclass': NullPool})
```

More info. here: https://docs.sqlalchemy.org/en/13/core/pooling.html#using-connection-pools-with-multiprocessing-or-os-fork

#### Execute Flask CLI commands

A safe way to do this is using the 'inv_poetry' script:
```bash
docker-compose run --rm --entrypoint="" <FLASK_SERVICE_NAME> inv_poetry <COMMAND>
```
** Replace `<FLASK_SERVICE_NAME>` and `<COMMAND>`


#### Restart gunicorn workers

```bash
docker-compose run --rm --entrypoint="" <FLASK_SERVICE_NAME> restart_workers
```
** Replace `<FLASK_SERVICE_NAME>`


#### Aditional Information

This image supports the expansion of secrets with the syntax.: `DOCKER-SECRET->secret_name`


