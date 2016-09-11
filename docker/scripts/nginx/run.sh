#!/bin/sh
envsubst '$$NGINX_HOST' < /etc/nginx/default.conf > /etc/nginx/conf.d/default.conf
nginx -g 'daemon off;'
