# Dockerfile
FROM nocodb/nocodb:latest

# Set environment variables that Railway will populate
ENV PORT=${PORT:-8080}
ENV NC_PUBLIC_URL=${RAILWAY_STATIC_URL}

# Railway health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:${PORT}/api/v1/health || exit 1

# Expose the port
EXPOSE ${PORT}

# Start NocoDB
CMD ["node", "docker/main.js"]

---

# railway.toml
[build]
dockerfile = "Dockerfile"

[deploy]
healthcheckPath = "/api/v1/health"
healthcheckTimeout = 300
restartPolicyType = "ON_FAILURE"
restartPolicyMaxRetries = 10

---

# .gitignore
node_modules/
.env
*.log
.DS_Store

---

# README.md
# NocoDB for Railway

This repository deploys NocoDB on Railway with proper configuration.

## Environment Variables Required:

- `NC_DB`: Database connection string
- `NC_AUTH_JWT_SECRET`: JWT secret for authentication
- `PORT`: Port (Railway sets this automatically)

## Deploy Steps:

1. Fork this repository
2. Connect to Railway
3. Set environment variables
4. Deploy

---

# package.json
{
  "name": "nocodb-railway",
  "version": "1.0.0",
  "description": "NocoDB deployment for Railway",
  "scripts": {
    "start": "node docker/main.js"
  },
  "dependencies": {},
  "engines": {
    "node": ">=18"
  }
}
