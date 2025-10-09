FROM node:20-bullseye

RUN npm install -g genieacs@1.2.13

ENV PORT=7567

CMD ["sh", "-c", "node /usr/local/lib/node_modules/genieacs/bin/genieacs-fs --interface 0.0.0.0 --port ${PORT:-7567}"]

