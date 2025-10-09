FROM node:20-bullseye

RUN npm install -g genieacs@1.2.13

ENV PORT=7567

CMD ["node", "/usr/local/lib/node_modules/genieacs/bin/genieacs-fs", "--port", "${PORT:-7567}"]

