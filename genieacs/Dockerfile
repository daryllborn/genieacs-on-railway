FROM node:20-bullseye

RUN npm install -g genieacs@1.2.13

ENV PORT=7547

CMD ["node", "/usr/local/lib/node_modules/genieacs/bin/genieacs-cwmp", "--port", "${PORT:-7547}"]

