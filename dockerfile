FROM alpine:latest

ENV HOST localhost
ENV PORT port

RUN apk update
RUN apk add git php7 php7-mbstring redis-server && \
  curl -sS https://getcomposer.org/install | php -- --install-dir=/usr/loca/bin --filname=composer && \
	chmod +x /usr/local/bin/composer

MKDIR /drfts-tz

WORKDIR /drfts-tz

RUN git clone https://github.com/insaint03/drfts-teezer.git
RUN redis-server --daemonize yes

RUN composer install && \
  composer update && \
  composer test && \
  php -S {HOST}:{PORT} -t public public/index.php
  
