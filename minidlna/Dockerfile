FROM alpine:3.11

RUN apk add minidlna && \
    rm -rf /var/apt/lists/*

VOLUME /data

COPY ./rootfs /

# UDP 1900 for UPnP
# 8200 for the web interface
EXPOSE 1900/udp
EXPOSE 8200

ENTRYPOINT ["/usr/sbin/minidlnad", "-d", "-f", "/minidlna.conf"]
