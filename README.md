# nervos-analytics

## Quickstart

### Create a .env file
```
cp sample.env .env
```

### Update .env config variables

> Note: POSTGRES and READONLY variables are only used when postgres starts the first time.

```
POSTGRES_USER=nervos
POSTGRES_PASSWORD=changeme
READONLY_USER=readonly_user
READONLY_PASSWORD=readonly
```

### Start the Node / Chain Grabber / Explorer
```
docker-compose up -d
``` 

## Commands

### Current info about your node:
```
docker-compose exec node info
```

### Access Chain Grabber DB (add -p <port> if port changed):
```
psql -U <POSTGRES_USER> ckb_explorer_development
```

### View web UI:
* Open a browser and go to http://localhost

## Troubleshooting

### If Postgres port 5432 is already in use...

If you already have Postgres running locally, change the port for the postgres service in `docker-compose.yml`.  For example, 5433:5432 will expose it as 5433 locally (it will remain 5432 internally).

```
    ports:
      - "5433:5432"
```

### If port 3000 is already in use...

The back end for explorer defaults to 3000.  If you already something running on that port, change the port for the postgres service in `docker-compose.yml` as well as in the EXPLORER_URL variable in .env.  For example, 3001:3000 will expose it as 3001 locally (it will remain 3000 internally).

```
EXPLORER_URL=http://localhost:3001
```
```
    ports:
      - "3001:3000"
```

### If you are accessing the explorer from other computers...

The back end for explorer defaults to 3000 and is assumed to be on localhost.  If you are accessing the explorer UI from another computer, you'll need to provide a URL that will get you to the local service.  For example, if your URL is https://myserver.mydomain.com:

```
EXPLORER_URL=https://myserver.mydomain.com
EXPLORER_BACKEND_URL=http://myserver.mydomain.com:3000
```

### If port 80 is already in use...

If you already have something running on port 80, change the port for the node service in the `docker-compose.yml` file.  For example, 8080:9053 would expose it as 8080.

```
    ports:
      - "8080:9053"
```