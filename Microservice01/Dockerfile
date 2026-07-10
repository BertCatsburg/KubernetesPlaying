FROM node:current-alpine

WORKDIR /app

COPY code/package.json ./
RUN npm install

COPY code/src /app/src

CMD ["npm", "start"]