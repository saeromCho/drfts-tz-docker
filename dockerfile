FROM alpine:latest

ENV HOST localhost
ENV PORT port

RUN apk update
RUN apk add curl git php7 php7-openssl php7-json php7-phar php7-mbstring redis && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
	chmod +x /usr/local/bin/composer

RUN mkdir /drfts-tz

WORKDIR /drfts-tz

RUN git clone https://github.com/insaint03/drfts-tz.git
RUN redis-server --daemonize yes

RUN composer install && \
  composer update && \
  composer test && \
  php -S {HOST}:{PORT} -t public public/index.php
  
