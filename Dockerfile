FROM node:12.14.1 as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ./ .
RUN npm run build

FROM nginx:latest as production-stage
RUN mkdir /app
COPY --from=build-stage /app/dist /app
RUN ls -lthr /app
COPY deploy/nginx.conf /etc/nginx/nginx.conf
COPY deploy/locations.conf /etc/nginx/locations.conf