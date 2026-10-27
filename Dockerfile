# Dockerfile — Giorno 10 Broken Project - FIXED
FROM node:22-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY tsconfig.json ./
COPY src/ ./src/
COPY prisma/ ./prisma/
RUN npx prisma generate
RUN npm run build

FROM node:22-alpine AS production
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma

# FIX BUG 1: Rimosso secret dal Dockerfile
# Le variabili sensibili vengono ora passate via docker-compose.yml

# FIX BUG 2: Aggiungi script entrypoint per Prisma migrate
COPY scripts/entrypoint.sh ./
RUN chmod +x ./entrypoint.sh

# FIX BUG 3: HEALTHCHECK con Node nativo (zero dipendenze extra)
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', r => process.exit(r.statusCode === 200 ? 0 : 1)).on('error', () => process.exit(1))" || exit 1

ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 3000
