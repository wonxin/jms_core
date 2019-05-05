## jms_core
jumpserver core component, without database, redis.

### Environments
####  SECRET_KEY
keep the secret key used in production secret.

Generate random `SECRET_KEY`:
```
cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 50
```

#### BOOTSTRAP_TOKEN
Pre share token, used by coco and guacamole to register.

Generate random `BOOTSTRAP_TOKEN`:
```
cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 16
```

#### Database setting
Database setting, Support sqlite3, mysql, postgres.

* DB_HOST
* DB_PORT
* DB_NAME
* DB_USER
* DB_PASSWORD

#### Redis setting
Use Redis as broker for celery and web socket.

* REDIS_HOST
* REDIS_PORT
* REDIS_PASSWORD
* REDIS_DB_CELERY
* REDIS_DB_CACHE

### Volume
Record medias directory.
```
/opt/jumpserver/data
```

log files directory.
```
/opt/jumpserver/logs
```
