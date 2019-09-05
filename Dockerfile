FROM python:3.6-alpine
LABEL maintainer="aeternus <aeternus@aliyun.com>"
LABEL jumpserver.version=1.5.2
LABEL python.version=3.6

WORKDIR /opt/jumpserver

RUN set -ex \
    \
    ## jumpserver
    && apk add --no-cache --virtual .build-deps gcc musl-dev make git \
    && cd /opt \
    && git clone --branch 1.5.2 --depth=1 https://github.com/jumpserver/jumpserver.git \
    && cd /opt/jumpserver/ \
    && rm -rf .git* \
    && apk add --no-cache $(cat requirements/alpine_requirements.txt) \
    # jms-storage 0.0.23 has requirement elasticsearch==6.1.1, urllib3==1.25.2
    # elasticsearch 6.1.1 has requirement urllib3<1.23,>=1.21.1
    # ?
    # django-radius 1.3.3 has requirement future==0.16.0
    && pip3 install --no-cache-dir --upgrade pip setuptools \
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

VOLUME /opt/jumpserver/data
VOLUME /opt/jumpserver/logs

EXPOSE 80 8080

ENTRYPOINT ["/opt/entrypoint.sh"]
