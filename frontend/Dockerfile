# Base image for dev
FROM node:14.13.0-alpine3.12 AS dev
EXPOSE 8080
WORKDIR /app

COPY ./package*.json ./
RUN npm install

COPY . .
CMD ["npm", "run", "serve"]


# Compile prod build
FROM dev AS build
RUN npm run build


# Serve with Nginx
FROM nginx:1.19.3-alpine AS prod
COPY --from=build /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf
