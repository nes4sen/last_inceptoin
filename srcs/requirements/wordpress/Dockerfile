FROM	debian:bookworm

RUN	apt-get update && apt-get install -y \
	php-fpm \
	php-mysql \
	php-cli \
	mariadb-client \
	curl \
	tar \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    	&& chmod +x wp-cli.phar \
    	&& mv wp-cli.phar /usr/local/bin/wp

RUN	mkdir -p /var/www/wordpress

