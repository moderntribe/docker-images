#!/bin/sh

chown -R nginx:nginx /srv/site
/usr/sbin/php-fpm7 &
nginx -g 'daemon off;' &
wait