FROM alpine:3.12.0
ARG KEEWEB_VERSION

RUN apk add nginx curl unzip supervisor

COPY ./rootfs /

RUN curl -L https://github.com/keeweb/keeweb/releases/download/v${KEEWEB_VERSION}/KeeWeb-${KEEWEB_VERSION}.html.zip -o /tmp/keeweb.zip && \
    unzip /tmp/keeweb.zip -d /var/www && \
    sed -i -e 's/(no-config)/config.json/g' /var/www/index.html && \
    chown -R nginx:nginx /var/www && \
    mkdir -p /run/nginx

ENTRYPOINT [ "/usr/bin/supervisord", "-nc", "/etc/supervisor/supervisord.conf" ]