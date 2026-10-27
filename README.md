# Broken Project — Giorno 10: Docker, Nginx, CI/CD

## Bug 1 — 🔴 Nginx bufferizza SSE (streaming non funziona)
**Sintomi**: il client SSE non riceve eventi in tempo reale — li riceve tutti insieme alla fine.
**File**: `nginx/nginx.conf`

## Bug 2 — 🟡 Prisma migrate non eseguito in Docker
**Sintomi**: il container Express parte ma crasha con "table does not exist".
**File**: `Dockerfile`

## Bug 3 — 🟢 Secret hardcoded nel Dockerfile
**Sintomi**: il JWT_SECRET è visibile a chiunque abbia accesso al Dockerfile/immagine.
**File**: `Dockerfile`

## Feature opzionale
Aggiungi un workflow GitHub Actions con lint + test + Docker build.
