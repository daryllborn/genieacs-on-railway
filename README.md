# GenieACS on Railway

This project packages the GenieACS stack for deployment on Railway. The services are containerised and can be orchestrated locally with Docker Compose or deployed as individual Railway services built from the provided Dockerfiles.

## Local Development

1. Copy the sample environment variables and adjust for your setup:

```
cp .env.local.sample .env.local
```

Populate the following values:

- `GENIEACS_MONGODB_CONNECTION_URL` – defaults to the local MongoDB service (`mongodb://mongodb:27017/genieacs`).
- `GENIEACS_REDIS_HOST` / `GENIEACS_REDIS_PORT` – default to `redis:6379` for the local Redis service.
- Optionally set `GENIEACS_UI_JWT_SECRET` for a deterministic UI session secret during development.

2. Start the stack using the `local-db` profile to include MongoDB and Redis:

```
docker compose --profile local-db up -d --build
```

## Railway Deployment

Railway builds each service from your fork (`https://github.com/daryllborn/genieacs.git`). Set up one Railway service per component:

| Service         | Dockerfile Path           | Required Variables                                                                     |
| --------------- | ------------------------- | -------------------------------------------------------------------------------------- |
| `genieacs`      | `genieacs/Dockerfile`     | `GENIEACS_MONGODB_CONNECTION_URL`, `GENIEACS_REDIS_HOST`, `GENIEACS_REDIS_PORT`       |
| `genieacs-nbi`  | `genieacs-nbi/Dockerfile` | Same as `genieacs`                                                                    |
| `genieacs-fs`   | `genieacs-fs/Dockerfile`  | `GENIEACS_MONGODB_CONNECTION_URL`                                                     |
| `genieacs-gui`  | `gui/Dockerfile`          | `GENIEACS_MONGODB_CONNECTION_URL`, `GENIEACS_REDIS_HOST`, `GENIEACS_REDIS_PORT`       |

*(All services build from the fork with Node 20 and `npm install`.)*

### Environment Variables

- Map Railway’s managed MongoDB connection string to `GENIEACS_MONGODB_CONNECTION_URL` (`${{MongoDB.DATABASE_URL}}`).
- Map Redis host and port from your Redis service (`${{Redis.HOST}}`, `${{Redis.PORT}}`).
- Optionally expose `GENIEACS_REDIS_URL` if you prefer a single URI.
- Generate a long random value for `GENIEACS_UI_JWT_SECRET` in production.

### Configuration Tips

- Set `RAILWAY_DOCKERFILE_PATH` on each Railway service to point at the relevant Dockerfile if the repository layout is not automatically detected.
- The GUI reads `gui-config/config.json`; customise it before deploying, then rebuild the `gui` image.
- Optional: add a `genieacs-sim` service (Dockerfile in `genieacs-sim/`) to emulate TR-069 devices. See `docs/getting-started.md` for required env vars.

## Production Considerations

- Ensure TLS termination is handled via Railway’s domain settings or an upstream proxy and configure GenieACS accordingly.
- Monitor MongoDB and Redis usage to size your managed services appropriately.
- Configure logging and diagnostics integrations (e.g., Railway log drains) to capture GenieACS logs.

## Cleaning Up

Stop the local stack and remove containers:

```
docker compose down
```

Remove volumes if you want a clean state:

```
docker compose down -v
```

---

Refer to the [GenieACS installation guide](https://docs.genieacs.com/en/latest/installation-guide.html) for deeper operational details such as TLS configuration and advanced provisioning.

> Environment files (`.env`, `.env.*`, `env.local`) are ignored by Git; copy from samples when sharing credentials.

- See `docs/getting-started.md` for onboarding steps, the simulator reference, and operational checklists.

