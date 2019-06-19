FROM python:3.6-alpine
LABEL maintainer="wonxin <aeternus@aliyun.com>"
LABEL version.jumpserver=1.5.0
LABEL version.python=3.6

WORKDIR /opt/jumpserver

RUN set -ex \
    \
    # localtime
    && apk add --no-cache --virtual .tzdata-deps tzdata \
    && cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del --no-cache .tzdata-deps \
    \
    ## jumpserver
    && apk add --no-cache --virtual .build-deps gcc musl-dev make git \
    && cd /opt \
    && git clone --branch 1.5.0 --depth=1 https://github.com/jumpserver/jumpserver.git \
    && cd /opt/jumpserver/ \
    && rm -rf .git* \
    && apk add --no-cache $(cat requirements/alpine_requirements.txt) \
    # jms-storage 0.0.23 has requirement elasticsearch==6.1.1, urllib3==1.25.2
    # elasticsearch 6.1.1 has requirement urllib3<1.23,>=1.21.1
    # ?
    # django-radius 1.3.3 has requirement future==0.16.0
    && pip3 install --no-cache-dir "future==0.16.0" \
    && pip3 install --no-cache-dir -r requirements/requirements.txt \
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
    && apk del --no-cache .build-deps \
    && rm -rf /tmp/*

COPY jumpserver/config.yml.example /opt/jumpserver/config.yml.example
COPY nginx/jumpserver.conf /etc/nginx/conf.d/jumpserver.conf
COPY supervisord/supervisord.conf /opt/supervisord/supervisord.conf

COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

ENV SECRET_KEY=1234567890qwertyuiop \
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
