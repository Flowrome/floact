# Install dependencies only when needed
FROM node:16-alpine AS builder

RUN apk add --no-cache --update python3 py3-pip libc6-compat

RUN python3 -m pip install virtualenv

WORKDIR /

COPY . /monorepo

WORKDIR /monorepo

RUN rm yarn.lock
RUN rm package-lock.json
RUN rm apps/client/yarn.lock
RUN rm apps/client/package-lock.json
RUN rm apps/uilib/yarn.lock
RUN rm apps/uilib/package-lock.json
RUN rm -rf node_modules
RUN rm -rf apps/client/node_modules
RUN rm -rf apps/uilib/node_modules
RUN yarn run init
RUN yarn run build:client

ENV NEXT_TELEMETRY_DISABLED 1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

WORKDIR /

FROM node:16-alpine AS runner

COPY --from=builder /monorepo/apps/client/public /public
COPY --from=builder --chown=nextjs:nodejs /monorepo/apps/client/.next/standalone /
COPY --from=builder --chown=nextjs:nodejs /monorepo/apps/client/.next/static /.next/static

RUN rm -rf /monorepo

USER nextjs

EXPOSE 3004

ENV PORT 3004

CMD ["node", "server.js"]