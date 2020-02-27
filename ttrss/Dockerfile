# Based on https://git.tt-rss.org/fox/ttrss-docker-compose/src/master/app
FROM php:7.4.1-fpm-alpine3.11

RUN apk add --no-cache git postgresql-client dcron sudo nginx supervisor

# PHP Extension dependencies
RUN apk add --no-cache m4 libbz2 perl autoconf pkgconf dpkg-dev dpkg libmagic file libgcc libstdc++ \
                       binutils gmp isl libgomp libatomic mpfr4 mpc1 gcc musl-dev libc-dev g++ make re2c \
                       perl-error perl-git git-perl zlib-dev libpng-dev postgresql-dev oniguruma-dev icu-dev \
                       libxml2-dev libcurl curl-dev

RUN docker-php-ext-install -j$(nproc) gd pdo pgsql pdo_pgsql mbstring intl xml session dom fileinfo json curl

COPY ./rootfs /

RUN rm /etc/nginx/conf.d/default.conf

ENV DB_HOST DB_PORT DB_NAME DB_USER DB_PASS HOME_URL
EXPOSE 8080/tcp
CMD /startup.sh
