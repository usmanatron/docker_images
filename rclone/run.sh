#!/bin/sh
rclone mount REMOTE:"$REMOTE_NAME" /data --vfs-cache-mode writes --read-only --allow-other -vv