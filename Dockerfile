FROM python:alpine
LABEL maintainer "wonxin <aeternus@aliyun.com>"

WORKDIR /opt/jumpserver

RUN set -ex \
    ## jumpserver
    && apk update --no-cache \
    && apk add --no-cache git \
    && cd /opt \
    && git clone --depth=1 https://github.com/jumpserver/jumpserver.git \
    && cd /opt/jumpserver/ \
    && apk add --no-cache $(cat requirements/alpine_requirements.txt) \
    && pip install -r requirements/requirements.txt \
    && useradd jumpserver \
    && chown jumpserver:jumpserver -R /opt/jumpserver \
    ## nginx
    && apk add --no-cache nginx \
    && mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak \
    ## supervisor
    && apk add --no-cache supervisor \
    ## cleanup
    && apk del git \
    && apk cache clean \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

COPY config.yml.example /opt/jumpserver/config.yml.example
COPY jumpserver.conf /etc/nginx/conf.d/jumpserver.conf
COPY supervisor.ini /etc/supervisor.d/supervisor.ini

COPY jumpserver.sh /opt/jumpserver/jumpserver.sh
RUN chmod +x /opt/jumpserver/jumpserver.sh

ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8

ENV SECRET_KEY="1234567890qwertyuiop" \
    BOOTSTRAP_TOKEN="1234567890asdfghjkl" \
    DB_ENGINE=mysql \
    DB_HOST=127.0.0.1 \
    DB_PORT=3306 \
    DB_NAME=jumpserver \
    DB_USER=jumpserver \
    DB_PASSWORD="" \
    REDIS_HOST=127.0.0.1 \
    REDIS_PORT=6379 \
    REDIS_PASSWORD="" \
    REDIS_DB_CELERY=3 \
    REDIS_DB_CACHE=4

VOLUME /opt/jumpserver/data
VOLUME /opt/jumpserver/logs

EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord"]
