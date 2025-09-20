# NocoDB Integration - Railway Project

Aggiunge NocoDB al progetto Railway esistente utilizzando PostgreSQL condiviso.

## Environment Variables Richieste:

```bash
NC_DB=postgresql://${{Postgres.PGUSER}}:${{Postgres.PGPASSWORD}}@${{Postgres.PGHOST}}:${{Postgres.PGPORT}}/${{Postgres.PGDATABASE}}
NC_AUTH_JWT_SECRET=your-long-secure-jwt-secret-here
NC_REDIS_URL=${{Redis.REDIS_PRIVATE_URL}}
NC_PUBLIC_URL=${{RAILWAY_STATIC_URL}}
PORT=8080
NC_DISABLE_TELE=true
```

## Deploy:
1. Deploy questo repo come nuovo service nel progetto esistente
2. Configura le environment variables sopra
3. Accedi a NocoDB tramite Railway URL
