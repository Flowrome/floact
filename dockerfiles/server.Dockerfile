# Install dependencies only when needed
FROM python:3.10-alpine AS builder

WORKDIR /

COPY ./apps/server /server/app

COPY ./requirements.txt /server/requirements.txt

WORKDIR /server

RUN python3 -m pip install -r requirements.txt

WORKDIR /server/app

ARG FLOACT_ENV
ARG FLOACT_SERVER_FLASK_PORT
ARG FLOACT_SERVER_FLASK_HOST

ENV ENV ${FLOACT_ENV}

EXPOSE ${FLOACT_SERVER_FLASK_PORT}

CMD gunicorn --bind=${FLOACT_SERVER_FLASK_HOST}:${FLOACT_SERVER_FLASK_PORT} wsgi:app --timeout 200