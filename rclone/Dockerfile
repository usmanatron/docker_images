ARG VERSION=1.50.2
FROM rclone/rclone:$VERSION

ENV REMOTE_NAME="" RCLONE_CONFIG_REMOTE_USER="" RCLONE_CONFIG_REMOTE_KEY=""

COPY rclone.conf /root/.rclone.conf
COPY run.sh /run.sh

ENTRYPOINT /run.sh