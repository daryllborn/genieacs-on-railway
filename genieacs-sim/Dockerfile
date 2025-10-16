FROM node:16-bullseye

WORKDIR /sim

RUN apt-get update \
    && apt-get install -y --no-install-recommends git build-essential python3 \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/genieacs/genieacs-sim.git . \
    && npm install --production

ENV SIM_ACS_URL="http://127.0.0.1:7547/"
ENV SIM_DATA_MODEL="./data_model_202BC1-BM632w-8KA8WA1151100043.csv"
ENV SIM_PROCESSES="2"
ENV SIM_WAIT="1000"
ENV SIM_SERIAL_OFFSET="0"

CMD ["sh", "-c", "./genieacs-sim --acs-url ${SIM_ACS_URL} --data-model ${SIM_DATA_MODEL} --processes ${SIM_PROCESSES} --wait ${SIM_WAIT} --serial ${SIM_SERIAL_OFFSET}"]

