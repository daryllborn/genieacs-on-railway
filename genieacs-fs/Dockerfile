ARG GENIEACS_REPO=https://github.com/daryllborn/genieacs.git
ARG GENIEACS_REF=v1.3.5

FROM node:20-bullseye AS build
RUN apt-get update && apt-get install -y --no-install-recommends git python3 build-essential \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /src
ARG GENIEACS_REPO
ARG GENIEACS_REF
RUN git clone --depth 1 --branch "${GENIEACS_REF}" "${GENIEACS_REPO}" .
RUN corepack enable && pnpm install --frozen-lockfile
RUN pnpm run build
RUN pnpm prune --prod

FROM node:20-slim
ENV NODE_ENV=production
WORKDIR /app
COPY --from=build /src /app
RUN groupadd -r genieacs && useradd -r -g genieacs genieacs \
    && mkdir -p /data \
    && chown -R genieacs:genieacs /app /data
USER genieacs

ENV GENIEACS_FS_HOST=0.0.0.0
ENV GENIEACS_FS_PORT=7567

CMD ["node", "dist/bin/genieacs-fs"]

