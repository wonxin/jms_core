#!/bin/sh

if [ ! -f "/etc/jumpserver/config.yml" ]; then
    cp /etc/jumpserver/config.yml.example /etc/jumpserver/config.yml

    sed -i "s/SECRET_KEY:/SECRET_KEY: ${SECRET_KEY}/" /etc/jumpserver/config.yml
    sed -i "s/BOOTSTRAP_TOKEN:/BOOTSTRAP_TOKEN: ${BOOTSTRAP_TOKEN}/" /etc/jumpserver/config.yml
    sed -i "s/DB_ENGINE:/DB_ENGINE: ${DB_ENGINE}/" /etc/jumpserver/config.yml
    sed -i "s/DB_HOST:/DB_HOST: ${DB_HOST}/" /etc/jumpserver/config.yml
    sed -i "s/DB_PORT:/DB_PORT: ${DB_PORT}/" /etc/jumpserver/config.yml
    sed -i "s/DB_NAME:/DB_NAME: ${DB_NAME}/" /etc/jumpserver/config.yml
    sed -i "s/DB_USER:/DB_USER: ${DB_USER}/" /etc/jumpserver/config.yml
    sed -i "s/DB_PASSWORD:/DB_PASSWORD: ${DB_PASSWORD}/" /etc/jumpserver/config.yml
    sed -i "s/REDIS_HOST:/REDIS_HOST: ${REDIS_HOST}/" /etc/jumpserver/config.yml
    sed -i "s/REDIS_PORT:/REDIS_PORT: ${REDIS_PORT}/" /etc/jumpserver/config.yml
    sed -i "s/REDIS_PASSWORD:/REDIS_PASSWORD: ${REDIS_PASSWORD}/" /etc/jumpserver/config.yml
    sed -i "s/REDIS_DB_CELERY:/REDIS_DB_CELERY: ${REDIS_DB_CELERY}/" /etc/jumpserver/config.yml
    sed -i "s/REDIS_DB_CACHE:/REDIS_DB_CACHE: ${REDIS_DB_CACHE}/" /etc/jumpserver/config.yml
fi

source /opt/jumpserver/entrypoint.sh
