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

FROM node:16-alpine AS runner
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

EXPOSE 3004

ENV PORT 3004

CMD ["node", "server.js"]