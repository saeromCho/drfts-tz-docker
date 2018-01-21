FROM alpine:latest

ENV HOST localhost
ENV PORT port

RUN apk update
RUN apk add curl git php7 \
        php7-ctype \
        php7-curl \
        php7-dom \
        php7-fileinfo \
        php7-ftp \
        php7-iconv \
        php7-json \
        php7-mbstring \
        php7-mysqlnd \
        php7-openssl \
        php7-pdo \
        php7-pdo_sqlite \
        php7-pear \
        php7-phar \
        php7-posix \
        php7-session \
        php7-simplexml \
        php7-sqlite3 \
        php7-tokenizer \
        php7-xml \
        php7-xmlreader \
        php7-xmlwriter \
        php7-zlib redis && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
	chmod +x /usr/local/bin/composer

RUN git clone https://github.com/insaint03/drfts-tz.git
RUN redis-server --daemonize yes

WORKDIR /drfts-tz

RUN composer install && \
  composer update && \
  composer test && \
  php -S {HOST}:{PORT} -t public public/index.php
  
