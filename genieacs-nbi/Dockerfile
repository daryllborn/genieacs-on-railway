FROM node:20-bullseye

RUN npm install -g genieacs@1.2.13

ENV PORT=7557

CMD ["node", "/usr/local/lib/node_modules/genieacs/bin/genieacs-nbi", "--port", "${PORT:-7557}"]

