FROM openresty/openresty:1.15.8.2-alpine

WORKDIR /usr/local/openresty/nginx/conf

RUN rm -f /etc/nginx/conf.d/*

ENV SERVER_NAME example.com
ENV PORT 80
ENV CLIENT_MAX_BODY_SIZE 1m
ENV PROXY_READ_TIMEOUT 60s
ENV WORKER_PROCESSES auto

COPY ./config/endpoint.sh /
COPY ./config/nginx.conf.tmpl /
COPY ./src /lua

CMD sh /endpoint.sh