#!/bin/sh

set -e 


mkdir -p /etc/nginx/ssl

if [ ! -f /etc/nginx/ssl/inception.crt ]; then
	openssl req -x509 -nodes -days 777 -newkey rsa:2048 \
    		-keyout /etc/nginx/ssl/inception.key \
    		-out /etc/nginx/ssl/inception.crt \
    		-subj "CN=nosahimi.42.fr"
fi 

exec nginx -g "daemon off;"

