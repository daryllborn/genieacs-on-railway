FROM node:20-bullseye

RUN npm install -g genieacs@1.2.13

WORKDIR /app

RUN cp -R /usr/local/lib/node_modules/genieacs/public ./dist

COPY ./gui-config/config.json /app/dist/assets/config/config.json

ENV PORT=3000

CMD ["sh", "-c", "node /usr/local/lib/node_modules/genieacs/bin/genieacs-ui --interface 0.0.0.0 --port ${PORT:-3000}"]

