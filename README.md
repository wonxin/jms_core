## jms_core
Jumpserver core component, without database, redis.

## Features
Work with other jumpserver components:
* [jms_nginx](https://cloud.docker.com/repository/docker/wonxin/jms_nginx)
* jms_coco
* jms_guacamole
* mysql
* redis

## How to use this image

### Set environments
To run this docker, you must set these environments below first:

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

### Exposing external port
* **80** - Server record medias, static contents.
* **8080** - Jumpserver core port, contact with jms_coco, jms_guacamole.

## Run
Here is an example:
```
docker run --name jms_core -d \
    -p 80:80 \
    -p 8080:8080 \
    -v jms_core_data:/opt/jumpserver/data \
    -v jms_core_log:/opt/jumpserver/logs \
    -e SECRET_KEY=<secret_key> \
    -e BOOTSTRAP_TOKEN=<token> \
    -e DB_ENGINE=<db_engine> \
    -e DB_HOST=<db_host> \
    -e DB_PORT=<db_port> \
    -e DB_NAME=<db_name> \
    -e DB_USER=<db_user> \
    -e DB_PASSWORD=<db_password> \
    -e REDIS_HOST=<redis_host> \
    -e REDIS_PORT=<redis_port> \
    -e REDIS_PASSWORD=<redis_password> \
    -e REDIS_DB_CELERY=<celery_db_no> \
    -e REDIS_DB_CACHE=<cache_db_no> \
    wonxin/jms_core:<tag>
```

## Support
If you are having issues, please let me know. <aeternus@aliyun.com>

## License
The project is licensed under the [GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) license.

## Issue

urllib3 version incompatible in requirements/requirements.txt

* elasticsearch 6.1.1 has requirement urllib3<1.23,>=1.21.1
* jms-storage 0.0.23 has requirement urllib3==1.25.2
