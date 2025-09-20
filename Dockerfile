# Dockerfile
FROM nocodb/nocodb:latest

# Railway environment variables
ENV PORT=8080
EXPOSE 8080

# Health check for Railway
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/api/v1/health || exit 1
