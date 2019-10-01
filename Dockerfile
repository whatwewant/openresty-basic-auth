FROM nginx:1.17.2-alpine

RUN rm -rf /etc/nginx/conf.d/*

RUN apk add --no-cache --update apache2-utils

ENV SERVER_NAME example.com
ENV PORT 80
ENV CLIENT_MAX_BODY_SIZE 1m
ENV PROXY_READ_TIMEOUT 60s
ENV WORKER_PROCESSES auto

COPY ./config/endpoint.sh /
COPY ./config/nginx.conf.tmpl /

CMD sh /endpoint.sh