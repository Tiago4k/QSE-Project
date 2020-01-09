# Build Stage
FROM tiangolo/node-frontend:10 as build-stage

WORKDIR /app

COPY package*.json yarn.lock /app/

RUN yarn

COPY ./ /app/

RUN yarn build

# Production stage, based on Nginx
FROM nginx:1.15

COPY --from=build-stage /app/build/ /usr/share/nginx/html

COPY --from=build-stage /nginx.conf /etc/nginx/conf.d/default.conf
