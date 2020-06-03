FROM alpine:3.11.3

RUN apk add minidlna && \
    rm -rf /var/apt/lists/*

VOLUME /data

# UDP 1900 for UPnP
# 8200 for the web interface
EXPOSE 1900/udp
EXPOSE 8200

COPY ./rootfs /

ENTRYPOINT ["/usr/sbin/minidlnad", "-d", "-f", "/minidlna.conf"]
