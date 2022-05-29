FROM python:3.10-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PATH=$PATH:$HOME/
ENV POETRY_NO_INTERACTION true

WORKDIR /tmp
RUN python -m pip install --upgrade pip
RUN pip install poetry
RUN curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
RUN bash n latest
RUN npm install --global npm
RUN npm install --global postcss postcss-cli rollup

COPY ./env_secrets_expand.sh /
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
