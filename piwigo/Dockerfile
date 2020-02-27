FROM php:7.2-apache

ARG PIWIGO_VER=2.9.5

RUN apt-get update -y && \
    apt-get install -y libpng-dev libxml2-dev libldap2-dev unzip netcat ffmpeg mediainfo libmagickwand-dev --no-install-recommends && \
    pecl install imagick && \
    docker-php-ext-install -j$(nproc) gd xml mbstring xml xmlrpc mysqli zip intl ldap exif && docker-php-ext-enable imagick && \
    rm -rf /var/lib/apt/lists/*

# Piwigo
RUN cd /tmp && \
    curl -sSo piwigo.zip https://piwigo.org/download/dlcounter.php?code=$PIWIGO_VER && \
    unzip piwigo.zip && \
    mv piwigo /var/www/html/piwigo && \
    rm piwigo.zip && \
    #
    # Plugin - video-js v2.9.b
    curl -sSLo piwigo-videojs-2.9.b.zip https://github.com/xbgmsharp/piwigo-videojs/archive/v2.9.b.zip && \
    unzip piwigo-videojs-2.9.b.zip && \
    mv piwigo-videojs-2.9.b /var/www/html/piwigo/plugins/piwigo-videojs && \
    rm piwigo-videojs-2.9.b.zip && \
    #
    # Plugin - PHP Captcha v1.0.9
    curl -sSLo phpcaptchapiwigo-1.0.9.zip https://github.com/pstimpel/phpcaptchapiwigo/archive/v1.0.9.zip && \
    unzip phpcaptchapiwigo-1.0.9.zip && \
    mv phpcaptchapiwigo-1.0.9 /var/www/html/piwigo/plugins/phpcaptchapiwigo && \
    rm phpcaptchapiwigo-1.0.9.zip && \
    # 
    # Plugin - Better No Right Click v1.2
    curl -sSLo betterrightClick.zip https://piwigo.org/ext/download.php?rid=4860 && \
    unzip betterrightClick.zip && \
    mv betterrightClick /var/www/html/piwigo/plugins/betterrightClick && \
    rm betterrightClick.zip

COPY rootfs /

RUN a2enmod rewrite && \
    a2dissite 000-default.conf && \
    a2ensite piwigo.conf && \
    chown -R www-data:www-data /var/www/html/piwigo/ && \
    chmod -R 755 /var/www/html/piwigo/ && \
    chmod +x /root/*.sh

VOLUME [ "/var/www/html/piwigo/galleries" ]

CMD [ "/root/entrypoint.sh" ]