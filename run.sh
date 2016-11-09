#!/bin/bash

dockerize -wait tcp://rb_db:${DB_PORT} -timeout 20s

rb-site install --noinput \
       --domain-name="${DOMAIN:localhost}" \
       --site-root=/ --static-url=static/ --media-url=media/ \
       --db-type=${DB_TYPE} \
       --db-name="${DB_NAME}" \
       --db-host="rb_db" \
       --db-user="${DB_USER}" \
       --db-pass="${DB_PASSWORD}" \
       --cache-type=memcached --cache-info="memcached" \
       --web-server-type=lighttpd --web-server-port=8000 \
       --admin-user="${RB_ADMIN}" --admin-password=${RB_PASSWORD} --admin-email=${RB_ADMIN_EMAIL} \
       /var/www/reviewboard/



exec uwsgi --ini /etc/reviewboard/uwsgi.ini
