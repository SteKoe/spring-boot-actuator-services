FROM node:lts as builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npx parcel build --public-url /app
RUN ls -la /usr/src/app

FROM nginx:alpine
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html/app
RUN ls -la /usr/share/nginx/html
