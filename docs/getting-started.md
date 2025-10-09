# Getting Started with GenieACS

This guide walks new team members through the fundamentals of our GenieACS deployment so you can safely explore the platform and participate in day‑to‑day operations.

## Platform Overview

| Component | Purpose | Default Port | Notes |
| --- | --- | --- | --- |
| `genieacs` | Core CWMP/TR-069 service handling device sessions | 7547 | Requires MongoDB and Redis to be reachable. |
| `genieacs-nbi` | Northbound API used by GUI and integrations | 7557 | Use HTTPS/TLS termination in production. |
| `genieacs-fs` | File server for firmware/config delivery | 7567 | Stores payloads in MongoDB GridFS. |
| `genieacs-gui` | Web UI for operations teams | 3000 | Points to NBI via `gui-config/config.json`. |
| MongoDB | Primary datastore | 27017 | Railway managed service. |
| Redis | Job queue / cache | 6379 | Railway managed service. |

## Environment Variables

```
GENIEACS_MONGODB_CONNECTION_URL=mongodb://<user>:<pass>@<host>:<port>/<db>?authSource=admin
GENIEACS_REDIS_HOST=<redis-host>
GENIEACS_REDIS_PORT=<redis-port>
GENIEACS_UI_JWT_SECRET=<long-random-string>
```

- These values must be set on `genieacs`, `genieacs-nbi`, and `genieacs-fs` services.
- Keep the Mongo URI consistent across services to avoid schema drift.

## Local Development Checklist

1. Copy `.env.local.sample` to `.env.local` and adjust if needed.
2. Run `docker compose --profile local-db up -d --build`.
3. Visit `http://localhost:3000` and complete the initialization wizard.
4. Log in with `admin / admin`, then immediately change the password under **Users**.
5. Tear down with `docker compose down` (add `-v` to reset Mongo/Redis data).

## Railway Deployment Checklist

1. Create four services linked to this repo:
   - `genieacs` → `RAILWAY_DOCKERFILE_PATH=genieacs/Dockerfile`
   - `genieacs-nbi` → `RAILWAY_DOCKERFILE_PATH=genieacs-nbi/Dockerfile`
   - `genieacs-fs` → `RAILWAY_DOCKERFILE_PATH=genieacs-fs/Dockerfile`
   - `genieacs-gui` → `RAILWAY_DOCKERFILE_PATH=gui/Dockerfile`
2. Map managed MongoDB/Redis variables (no quotes) and set `GENIEACS_UI_JWT_SECRET`.
3. Redeploy each service; verify logs show `Worker listening` and no parse errors.
4. Visit the GUI public URL, run the wizard, and rotate the default credentials.

## First Operational Tasks

- **Provisioning Scripts:** Review existing presets/provisions and create a sandbox device profile for testing firmware upgrades.
- **Monitoring:** Configure Railway log streaming or hook into the corporate monitoring stack. Set alerts for repeated `MongoParseError` or `Worker died` messages.
- **Backups:** Document MongoDB backup strategy (Railway snapshots or external tooling) and schedule regular tests.

## Further Reading

- [GenieACS Installation Guide](https://docs.genieacs.com/en/latest/installation-guide.html)
- Repository README (deployment notes, environment configuration)

