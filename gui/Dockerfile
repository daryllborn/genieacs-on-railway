ARG GENIEACS_REF=v1.3.5

FROM node:20-bullseye AS build
RUN apt-get update && apt-get install -y --no-install-recommends git python3 build-essential \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /src
ARG GENIEACS_REF
RUN git clone --depth 1 --branch "${GENIEACS_REF}" https://github.com/genieacs/genieacs.git .
RUN corepack enable && pnpm install --frozen-lockfile
RUN pnpm --filter @genieacs/gui build
RUN pnpm prune --prod

FROM node:20-slim
ENV NODE_ENV=production
WORKDIR /app
COPY --from=build /src/apps/gui/dist ./dist
COPY --from=build /src/apps/gui/package.json ./package.json
COPY --from=build /src/apps/gui/pnpm-lock.yaml ./pnpm-lock.yaml
RUN groupadd -r genieacs && useradd -r -g genieacs genieacs \
    && mkdir -p /data \
    && chown -R genieacs:genieacs /app
USER genieacs

# GUI uses CLI entrypoint from root package; copy CLI as well
COPY --from=build /src /genieacs-src

ENV GENIEACS_GUI_HOST=0.0.0.0
ENV GENIEACS_GUI_PORT=3000

COPY ./gui-config/config.json /app/dist/assets/config/config.json

CMD ["node", "/genieacs-src/dist/bin/genieacs-ui"]

