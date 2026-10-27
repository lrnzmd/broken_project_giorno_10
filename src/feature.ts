// Feature opzionale — GitHub Actions workflow
// Crea .github/workflows/ci.yml con:
// 1. Trigger: push su main, PR su main
// 2. Job: lint → test → build Docker
// 3. Service: PostgreSQL per i test
// 4. Caching: node_modules con actions/cache
// 5. Build Docker image con tag basato sul commit SHA
