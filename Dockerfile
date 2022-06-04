FROM python:3-slim-buster

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PATH $PATH:$HOME/
ENV POETRY_NO_INTERACTION true
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /tmp
RUN python -m ensurepip
RUN pip install --no-cache --upgrade pip setuptools
RUN pip install poetry
RUN apt update && apt upgrade -y
RUN apt install -y curl
RUN curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
RUN bash n latest
RUN npm install --global npm
RUN npm install --global postcss postcss-cli rollup
RUN apt remove -y curl
RUN apt autoremove -y

COPY ./inv_poetry.sh /usr/local/bin/inv_poetry
RUN chmod +x /usr/local/bin/inv_poetry
COPY ./env_secrets_expand.sh /
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
