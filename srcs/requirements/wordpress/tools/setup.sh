#!/bin/bash

set -e

WP_PATH=/var/www/wordpress

DB_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
WP_ADMIN_PASSWORD=$(cat "$WP_ADMIN_PASSWORD_FILE")
WP_USER_PASSWORD=$(cat "$WP_USER_PASSWORD_FILE")

until	mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$DB_PASSWORD" --silent; do
		echo "Waiting for MariaDB..."
		sleep 2
done

cd "$WP_PATH"

if	[ ! -f "$WP_PATH/wp-config.php" ]; then
	wp core download --allow-root

    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="$MYSQL_HOST" \
        --allow-root

    wp core install \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root
     wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --allow-root

fi

chown	-R www-data:www-data "$WP_PATH"

exec php-fpm7.4 -F
