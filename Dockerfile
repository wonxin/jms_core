FROM python:3.6-alpine
LABEL maintainer="wonxin <aeternus@aliyun.com>"
LABEL version.jumpserver=v1.5.0
LABEL version.python=3.6

WORKDIR /opt/jumpserver

RUN set -ex \
    \
    # localtime
    && apk add --no-cache --virtual .tzdata-deps tzdata \
    && cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del --no-cache .tzdata-deps \
    \
    && apk upgrade --no-cache \
    \
    ## jumpserver
    && apk add --no-cache --virtual .build-dependencies gcc musl-dev make git \
    && cd /opt \
    && git clone --branch v1.5.0 --depth=1 https://github.com/jumpserver/jumpserver.git \
    && cd /opt/jumpserver/ \
    && rm -rf .git* \
    && apk add --no-cache $(cat requirements/alpine_requirements.txt) \
    ## django-radius 1.3.3 has requirement future==0.16.0
    #&& pip3 install --no-cache-dir "future==0.16.0" \
    && pip3 install --no-cache-dir -r requirements/requirements.txt \
    #&& adduser -D jumpserver \
    \
    ## nginx
    && apk add --no-cache nginx \
    && rm -f /etc/nginx/conf.d/default.conf \
    && mkdir /run/nginx \
    \
    ## supervisor
    && apk add --no-cache supervisor \
    \
    ## cleanup
    && apk del --no-cache .build-dependencies \
    && rm -rf /tmp/*

COPY jumpserver/config.yml.example /opt/jumpserver/config.yml.example
COPY nginx/jumpserver.conf /etc/nginx/conf.d/jumpserver.conf
COPY supervisord/supervisord.conf /opt/supervisord/supervisord.conf

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENV LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    \
    SECRET_KEY=1234567890qwertyuiop \
    BOOTSTRAP_TOKEN=1234567890asdfghjkl \
    \
    DB_ENGINE=mysql \
    DB_HOST=127.0.0.1 \
    DB_PORT=3306 \
    DB_NAME=jumpserver \
    DB_USER=jumpserver \
    DB_PASSWORD="" \
    \
    REDIS_HOST=127.0.0.1 \
    REDIS_PORT=6379 \
    REDIS_PASSWORD="" \
    REDIS_DB_CELERY=3 \
    REDIS_DB_CACHE=4

VOLUME /opt/jumpserver/data
VOLUME /opt/jumpserver/logs

EXPOSE 80 8080

ENTRYPOINT ["/opt/entrypoint.sh"]
