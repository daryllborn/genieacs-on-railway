FROM node:20-bullseye

RUN npm install -g genieacs@1.2.13

WORKDIR /app

RUN cp -R /usr/local/lib/node_modules/genieacs-gui/dist ./dist

COPY ./gui-config/config.json /app/dist/assets/config/config.json

CMD ["node", "/usr/local/lib/node_modules/genieacs/bin/genieacs-ui"]

