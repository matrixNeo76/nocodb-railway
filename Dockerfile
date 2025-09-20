# Dockerfile
FROM nocodb/nocodb:latest

# Railway environment variables
ENV PORT=8080
EXPOSE 8080

# Health check for Railway
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/api/v1/health || exit 1

---

# package.json (Railway lo rileva come Node.js project)
{
  "name": "nocodb-railway-integration",
  "version": "1.0.0",
  "description": "NocoDB integration for existing Railway project",
  "main": "index.js",
  "scripts": {
    "start": "echo 'NocoDB container started'"
  },
  "engines": {
    "node": ">=18"
  }
}

---

# railway.toml (configurazione Railway)
[build]
dockerfile = "Dockerfile"

[deploy]
healthcheckPath = "/api/v1/health"
healthcheckTimeout = 300
restartPolicyType = "ON_FAILURE"

---

# README.md
# NocoDB for Existing Railway Project

This deploys ONLY NocoDB (no additional databases) 
to integrate with existing PostgreSQL/Redis services.

## Environment Variables Needed:

- NC_DB: PostgreSQL connection string
- NC_AUTH_JWT_SECRET: JWT secret
- NC_REDIS_URL: Redis connection (optional)
- PORT: 8080 (Railway sets automatically)

## Setup:
1. Deploy this repo as new service in existing Railway project
2. Configure environment variables to use existing PostgreSQL
3. Access NocoDB at your Railway URL
