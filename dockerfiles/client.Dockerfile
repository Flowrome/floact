# Install dependencies only when needed
FROM node:16-alpine AS builder

ARG FLOACT_NODE_ENV
ARG FLOACT_NEXT_TELEMETRY_DISABLED

ENV NODE_ENV=$FLOACT_NODE_ENV
ENV NEXT_TELEMETRY_DISABLED=$FLOACT_NEXT_TELEMETRY_DISABLED

RUN echo $FLOACT_NODE_ENV && echo $FLOACT_NEXT_TELEMETRY_DISABLED

RUN apk add --no-cache --update libc6-compat
RUN apk add --no-cache  chromium --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main/

WORKDIR /

COPY . /monorepo

WORKDIR /monorepo

RUN rm -rf apps/server
RUN rm yarn.lock
RUN rm package-lock.json
RUN rm apps/client/yarn.lock
RUN rm apps/client/package-lock.json
RUN rm apps/uilib/yarn.lock
RUN rm apps/uilib/package-lock.json
RUN rm -rf node_modules
RUN rm -rf apps/client/node_modules
RUN rm -rf apps/uilib/node_modules
RUN yarn run docker:init:client
RUN yarn run build:client

FROM node:16-alpine AS runner

ARG FLOACT_ENV
ARG FLOACT_NEXT_TELEMETRY_DISABLED

ENV NODE_ENV=$FLOACT_ENV
ENV NEXT_TELEMETRY_DISABLED=$FLOACT_NEXT_TELEMETRY_DISABLED

WORKDIR /app

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs


COPY --from=builder /monorepo/apps/client/public ./public

COPY --from=builder --chown=nextjs:nodejs /monorepo/apps/client/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /monorepo/apps/client/.next/static ./.next/static

WORKDIR /

RUN rm -rf /monorepo

WORKDIR /app

USER nextjs

ARG FLOACT_CLIENT_PORT

EXPOSE $FLOACT_CLIENT_PORT

ENV PORT=$FLOACT_CLIENT_PORT

CMD node server.js