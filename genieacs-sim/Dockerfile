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

CMD ["sh", "-c", "./genieacs-sim --acs ${SIM_ACS_URL} --serial ${SIM_SERIAL} --oui ${SIM_OUI} --product ${SIM_PRODUCT} ${SIM_USERNAME:+--username ${SIM_USERNAME}} ${SIM_PASSWORD:+--password ${SIM_PASSWORD}} ${SIM_INTERVAL:+--interval ${SIM_INTERVAL}} ${SIM_EXTRA_ARGS}"]

