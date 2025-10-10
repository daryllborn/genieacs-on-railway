FROM node:16-bullseye

WORKDIR /sim

RUN apt-get update \
    && apt-get install -y --no-install-recommends git build-essential python3 \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/genieacs/genieacs-sim.git . \
    && npm install --production

ENV SIM_ACS_URL=""
ENV SIM_SERIAL="SIM0001"
ENV SIM_OUI="A1B2C3"
ENV SIM_PRODUCT="SIM-ONT"
ENV SIM_USERNAME=""
ENV SIM_PASSWORD=""
ENV SIM_INTERVAL=""
ENV SIM_EXTRA_ARGS=""

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

