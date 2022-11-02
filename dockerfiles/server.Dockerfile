# Install dependencies only when needed
FROM python:3.10-alpine AS builder

WORKDIR /

COPY ./apps/server /server/app

COPY ./apps/requirements.txt /server/requirements.txt

WORKDIR /server

RUN python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt

WORKDIR /server/app

ARG FLOACT_ENV
ARG FLOACT_SERVER_FLASK_PORT

ENV ENV=${FLOACT_ENV}

EXPOSE ${FLOACT_SERVER_FLASK_PORT}

CMD [ "gunicorn", "--bind=0.0.0.0:${FLOACT_SERVER_FLASK_PORT}",  "wsgi:app" ]