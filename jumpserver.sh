#!/bin/bash

if [ ! -f "/opt/jumpserver/config.yml" ]; then
    cp /opt/jumpserver/config.yml.example /opt/jumpserver/config.yml

    sed -i -e "s/SECRET_KEY:/SECRET_KEY: ${SECRET_KEY}/" \
           -e "s/BOOTSTRAP_TOKEN:/BOOTSTRAP_TOKEN: ${BOOTSTRAP_TOKEN}/" \
           -e "s/DB_ENGINE:/DB_ENGINE: ${DB_ENGINE}/" \
           -e "s/DB_HOST:/DB_HOST: ${DB_HOST}/" \
           -e "s/DB_PORT:/DB_PORT: ${DB_PORT}/" \
           -e "s/DB_NAME:/DB_NAME: ${DB_NAME}/" \
           -e "s/DB_USER:/DB_USER: ${DB_USER}/" \
           -e "s/DB_PASSWORD:/DB_PASSWORD: ${DB_PASSWORD}/" \
           -e "s/REDIS_HOST:/REDIS_HOST: ${REDIS_HOST}/" \
           -e "s/REDIS_PORT:/REDIS_PORT: ${REDIS_PORT}/" \
           -e "s/REDIS_PASSWORD:/REDIS_PASSWORD: ${REDIS_PASSWORD}/" \
           -e "s/REDIS_DB_CELERY:/REDIS_DB_CELERY: ${REDIS_DB_CELERY}/" \
           -e "s/REDIS_DB_CACHE:/REDIS_DB_CACHE: ${REDIS_DB_CACHE}/" /opt/jumpserver/config.yml
fi

/opt/jumpserver/entrypoint.sh
