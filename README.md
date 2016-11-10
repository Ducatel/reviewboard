# Reviewboard

Image which include [reviewboard](https://www.reviewboard.org), a peer review tool.

This images work with:
* `mysql` or `postgresql` database
* `Subversion` and `git` SCM
* `memcached` for the cache server

## How to run it

You must link your database to this container with `rb_db` alias and the cache server with `memcached` alias


Run a database instance
```
docker run -d --name database -e MYSQL_ROOT_PASSWORD=reviewboard -e MYSQL_USER=reviewboard -e MYSQL_PASSWORD=reviewboard -e MYSQL_DATABASE=reviewboard mysql
```

Run memcache instance
```
docker run -d --name cache memcached
```

Run the Reviewboard and link it to cache and database server
```
docker run -d --name reviewboard -p "8000:8000" --link "cache:memcached" --link "database:rb_db" ducatel/reviewboard
```

The web interface is available on port `8000`

You should use `docker-compose` to do that. An example of [docker-compose.yml](https://github.com/Ducatel/reviewboard/blob/master/docker-compose.yml) file is present in this repo.

## Configuration variables

You can configure this images with some environment variables:

* `DB_TYPE` 
    * The database server you want to use. `mysql` or `postgresql`
    * Default value: `mysql`
* `DB_PORT`
    * The port of database you want to use.
    * Default value: `3306`
* `DB_NAME`
    * The database name you want to use
    * Default value: `reviewboard`
* `DB_USER`
    * The database user you want to use
    * Default value: `reviewboard`
* `DB_PASSWORD`
    * The password associated to your database user
    * Default value: `reviewboard`
* `RB_ADMIN`
    * The login admin for the Reviewboard instance
    * Default value: `admin`
* `RB_PASSWORD`
    * The password of Reviewboard admin
    * Default value: `admin`
* `RB_ADMIN_EMAIL`
    * The email of Reviewboard admin
    * Default value: `admin@example.com`
* `UWSGI_PROCESSES`
    * The number of thread use by the web server
    * Default value: `10`

## Exposed volume

This container expose volume:
* `/media` where the uploaded files are stored
* `/var/www` where reviewboard conf are stored


