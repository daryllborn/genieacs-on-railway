FROM node:20-bullseye

RUN npm install -g genieacs@1.2.13

ENV PORT=7547

CMD ["sh", "-c", "node /usr/local/lib/node_modules/genieacs/bin/genieacs-cwmp --interface 0.0.0.0 --port ${PORT:-7547}"]

