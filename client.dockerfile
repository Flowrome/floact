# Install dependencies only when needed
FROM node:16-alpine AS builder

RUN apk add --no-cache libc6-compat

WORKDIR /
RUN ls -l

COPY . /monorepo

WORKDIR /monorepo

RUN ls -l
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