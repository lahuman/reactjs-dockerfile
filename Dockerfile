# build environment
FROM node:12.2.0-alpine as build

# 앱 디렉터리 생성
WORKDIR /usr/src/app

COPY . .

RUN npm install

RUN npm run build

# production environment
FROM nginx:1.16.0-alpine

COPY default.conf /etc/nginx/conf.d/default.conf
COPY expires.conf /etc/nginx/conf.d/expires.conf

COPY --from=build /usr/src/app/build /usr/src/app/build
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
