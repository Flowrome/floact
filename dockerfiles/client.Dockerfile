# Install dependencies only when needed
FROM node:16-alpine AS builder

RUN apk add --no-cache --update libc6-compat

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

ENV NEXT_TELEMETRY_DISABLED 1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

WORKDIR /

RUN mkdir /app
RUN mkdir /app/public
RUN mkdir /app/.next
RUN mkdir /app/.next/static
RUN cp -R monorepo/apps/client/public/* /app/public
RUN cp -R monorepo/apps/client/.next/standalone/* /app
RUN cp -R monorepo/apps/client/.next/static/* /app/.next/static
RUN chown nextjs:nodejs /app
RUN chown nextjs:nodejs /app/.next/static

RUN rm -rf /monorepo

WORKDIR /app

USER nextjs

EXPOSE 3004

ENV PORT 3004

CMD ["node", "server.js"]
# CMD ["ls", "-alR"]