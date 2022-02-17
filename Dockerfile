FROM node:14.19.0-alpine3.15

WORKDIR /app

COPY package.json package.json

RUN \
  echo "Installing the packages"; \
  npm install;

COPY src/ src/

CMD [ "node", "src/index.js" ]
EXPOSE "3000"


LABEL tp.docker.workshop="app"
