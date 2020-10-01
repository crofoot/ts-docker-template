FROM node:14.10.1-alpine3.12 AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:14.10.1-alpine3.12
WORKDIR /app
COPY --from=build /app/package*.json /app/
COPY --from=build /app/dist/ /app/
COPY .env* /app/
RUN ls
RUN npm install --production

CMD ["node", "index.js"]