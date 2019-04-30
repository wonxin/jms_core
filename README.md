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
