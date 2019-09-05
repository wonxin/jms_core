#!/bin/sh

if [ ! -f "/opt/jumpserver/config.yml" ]; then
    mv /opt/jumpserver/config.yml.example /opt/jumpserver/config.yml

    sed -e "s/SECRET_KEY:/SECRET_KEY: ${SECRET_KEY:-1234567890qwertyuiop}/" \
        -e "s/BOOTSTRAP_TOKEN:/BOOTSTRAP_TOKEN: ${BOOTSTRAP_TOKEN:-1234567890asdfghjkl}/" \
        -e "s/DB_ENGINE:/DB_ENGINE: ${DB_ENGINE:-mysql}/" \
        -e "s/DB_HOST:/DB_HOST: ${DB_HOST:-127.0.0.1}/" \
        -e "s/DB_PORT:/DB_PORT: ${DB_PORT:-3306}/" \
        -e "s/DB_NAME:/DB_NAME: ${DB_NAME:-jumpserver}/" \
        -e "s/DB_USER:/DB_USER: ${DB_USER:-jumpserver}/" \
        -e "s/DB_PASSWORD:/DB_PASSWORD: ${DB_PASSWORD:-jumpserver}/" \
        -e "s/REDIS_HOST:/REDIS_HOST: ${REDIS_HOST:-redis}/" \
        -e "s/REDIS_PORT:/REDIS_PORT: ${REDIS_PORT:-6379}/" \
        -e "s/REDIS_PASSWORD:/REDIS_PASSWORD: ${REDIS_PASSWORD:-redis}/" \
        -e "s/REDIS_DB_CELERY:/REDIS_DB_CELERY: ${REDIS_DB_CELERY:-3}/" \
        -e "s/REDIS_DB_CACHE:/REDIS_DB_CACHE: ${REDIS_DB_CACHE:-4}/" \
        -i /opt/jumpserver/config.yml
fi

/usr/bin/supervisord -c /opt/supervisord/supervisord.conf
