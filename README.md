# DOCKER FLASK
---

This docker image is prepared to run Flask applications. Your flask project must use poetry. In addition, this image provides npm with rollup and postcss.

You can customize gunicorn startup with the following environment variables:

| ENV. VAR | DEFAULT |
|----------|---------|
| $GUNICORN_TIMEOUT | 200 | 
| $GUNICORN_KEEP_ALIVE | 5 |
| $GUNICORN_MAX_REQUESTS | 10000 |


This image supports the expansion of secrets with the syntax.: `DOCKER-SECRET->secret_name`