## jms_core
jumpserver core component

### Keys
Generate `SECRET_KEY`:
```
cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 50
```

Generate `BOOTSTRAP_TOKEN`:
```
cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 16
```

### Environments
* SECRET_KEY
* BOOTSTRAP_TOKEN
* DB_ENGINE
* DB_HOST
* DB_PORT
* DB_NAME
* DB_USER
* DB_PASSWORD
* REDIS_HOST
* REDIS_PORT
* REDIS_PASSWORD
* REDIS_DB_CELERY
* REDIS_DB_CACHE
