FROM node:20-bullseye

RUN npm install -g genieacs@1.2.13 \
  && ln -s /usr/local/lib/node_modules/genieacs /genieacs

ENV NODE_PATH=/usr/local/lib/node_modules

WORKDIR /genieacs

CMD ["genieacs"]

