FROM debian:bookworm

RUN	apt-get update && apt-get install -y /
	nginx /
	openssl /
	&& rm -rf /var/lib/apt/lists/*

RUN	mkdir -p /etc/nginx/ssl

RUN 	openssl req -x509 -nodes -days 777 -newkey rsa:2048 \
    	-keyout /etc/nginx/ssl/inception.key \
    	-out /etc/nginx/ssl/inception.crt \
    	-subj "CN=nosahimi.42.fr"

COPY	conf/nginx.conf /etc/nginx/conf.d/

EXPOSE 443

ENTRYPOINT  ["nginx", "-g", "daemon off;"]
