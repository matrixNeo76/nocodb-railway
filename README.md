# Dockerfile
FROM nocodb/nocodb:latest

# Railway porta automatico
ENV PORT=8080
EXPOSE 8080

# Health check per Railway
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/api/v1/health || exit 1

---

# railway.toml
[build]
dockerfile = "Dockerfile"

[deploy]
healthcheckPath = "/api/v1/health"
healthcheckTimeout = 300
restartPolicyType = "ON_FAILURE"

---

# package.json
{
  "name": "nocodb-existing-project",
  "version": "1.0.0",
  "description": "NocoDB integration for existing Railway AI project",
  "engines": {
    "node": ">=18"
  }
}

---

# .gitignore
node_modules/
.env
*.log
.DS_Store

---

# README.md
# NocoDB Integration per Progetto Railway Esistente

Questo repository aggiunge **SOLO NocoDB** al tuo progetto Railway esistente, 
utilizzando i database PostgreSQL e Redis già presenti.

## ⚠️ IMPORTANTE
- **NON installa** nuovi database
- **USA** il PostgreSQL esistente del tuo progetto
- **USA** il Redis esistente del tuo progetto

## Environment Variables da Configurare:

```bash
# Database - USA QUELLO ESISTENTE
NC_DB=postgresql://${{Postgres.PGUSER}}:${{Postgres.PGPASSWORD}}@${{Postgres.PGHOST}}:${{Postgres.PGPORT}}/${{Postgres.PGDATABASE}}

# JWT Secret (genera uno random lungo)
NC_AUTH_JWT_SECRET=your-super-secure-jwt-secret-minimum-256-characters

# Redis esistente (opzionale ma consigliato)
NC_REDIS_URL=${{Redis.REDIS_PRIVATE_URL}}

# URL pubblico (Railway lo imposta automaticamente)
NC_PUBLIC_URL=${{RAILWAY_STATIC_URL}}

# Port (Railway lo imposta automaticamente)
PORT=8080

# Disabilita telemetria
NC_DISABLE_TELE=true
```

## Deploy Steps:

1. **Crea questo repository** con i file sopra
2. **Nel tuo progetto Railway esistente**: New Service → GitHub Repo
3. **Seleziona questo repository**
4. **Aggiungi le environment variables** elencate sopra
5. **Deploy e attendi** (2-3 minuti)
6. **Accedi a NocoDB** tramite l'URL Railway generato

## Struttura Finale Progetto:

```
Il Tuo Progetto Railway:
├── n8n Services
├── Flowise Services  
├── PostgreSQL ←── CONDIVISO con NocoDB
├── Redis ←────── CONDIVISO con NocoDB
├── Qdrant
├── SearXNG
├── Crawl4AI
└── NocoDB ←──── NUOVO (usa risorse esistenti)
```

## Note:
- NocoDB userà lo **stesso database** degli altri servizi
- **Comunicazione veloce** via Private Network
- **Zero costi** di traffico aggiuntivi
- **Gestione unificata** in un solo progetto
