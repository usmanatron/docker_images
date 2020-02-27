#!/bin/sh -ex

while ! pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USER; do
	echo waiting until $DB_HOST is ready...
	sleep 3
done

DST_DIR=/var/www/html/tt-rss
SRC_REPO=https://git.tt-rss.org/fox/tt-rss.git

export PGPASSWORD=$DB_PASS 

[ ! -e /var/www/html/index.php ] && cp /index.php /var/www/html

PSQL="psql -q -h $DB_HOST -p $DB_PORT -U $DB_USER $DB_NAME"

if [ ! -d $DST_DIR ]; then
	mkdir -p $DST_DIR
	git clone $SRC_REPO $DST_DIR
else
	cd $DST_DIR && \
		git config core.filemode false && \
		git pull origin master
fi

if [ ! -d $DST_DIR/plugins.local/nginx_xaccel ]; then
	git clone https://git.tt-rss.org/fox/ttrss-nginx-xaccel.git $DST_DIR/plugins.local/nginx_xaccel
else
	cd $DST_DIR/plugins.local/nginx_xaccel && \
		git config core.filemode false && \
	  	git pull origin master
fi

chown -R www-data:www-data $DST_DIR
chmod +x /etc/periodic/15min/*

for d in cache lock feed-icons; do
	chmod -R 777 $DST_DIR/$d
done

$PSQL -c "create extension if not exists pg_trgm"

RESTORE_SCHEMA=/var/www/html/tt-rss/backups/restore-schema.sql.gz

if [ -r $RESTORE_SCHEMA ]; then
	zcat $RESTORE_SCHEMA | $PSQL
elif ! $PSQL -c 'select * from ttrss_version'; then
	$PSQL < /var/www/html/tt-rss/schema/ttrss_schema_pgsql.sql
fi

if [ ! -s $DST_DIR/config.php ]; then
	SELF_URL_PATH=$(echo $HOME_URL | sed -e 's/[\/&]/\\&/g')

	sed \
		-e "s/define('DB_HOST'.*/define('DB_HOST', '$DB_HOST');/" \
		-e "s/define('DB_USER'.*/define('DB_USER', '$DB_USER');/" \
		-e "s/define('DB_NAME'.*/define('DB_NAME', '$DB_NAME');/" \
		-e "s/define('DB_PASS'.*/define('DB_PASS', '$DB_PASS');/" \
		-e "s/define('DB_PORT'.*/define('DB_PORT', '$DB_PORT');/" \
		-e "s/define('PLUGINS'.*/define('PLUGINS', 'auth_internal, note, nginx_xaccel');/" \
		-e "s/define('SELF_URL_PATH'.*/define('SELF_URL_PATH','$SELF_URL_PATH');/" \
		< $DST_DIR/config.php-dist > $DST_DIR/config.php

	cat >> $DST_DIR/config.php << EOF
		define('NGINX_XACCEL_PREFIX', '/tt-rss');
		define('_SKIP_SELF_URL_PATH_CHECKS', true);
EOF
	
fi

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
