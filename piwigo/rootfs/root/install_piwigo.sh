#!/bin/bash
# Automates the first-run installation of Piwigo.
# Idea from https://piwigo.org/forum/viewtopic.php?id=26121

# Only run if the config is missing
if [[ -f "/var/www/html/piwigo/local/config/database.inc.php" ]]
then
  echo '[INFO] Config file already exists - skipping installation'
  exit
fi

# Build POST request to setup database
declare -a post_options
post_options+=("install=true")
post_options+=("language=en_UK")
post_options+=("prefix=piwigo_")
post_options+=("dbhost=$PIWIGO_DB_HOST")
post_options+=("dbuser=$PIWIGO_DB_USER")
post_options+=("dbpasswd=$PIWIGO_DB_PASSWORD")
post_options+=("dbname=$PIWIGO_DB_NAME")
post_options+=("admin_name=$PIWIGO_ADMIN_USER")
post_options+=("admin_pass1=$PIWIGO_ADMIN_PASSWORD")
post_options+=("admin_pass2=$PIWIGO_ADMIN_PASSWORD")
post_options+=("admin_mail=$PIWIGO_ADMIN_EMAIL")
post_options+=("newsletter_subscribe=false")
post_options+=("install=Start%20installation")

post_string=$(IFS=\& ; echo "${post_options[*]}")

cd /var/www/html/piwigo || exit 1
php --run="parse_str(\$argv[1], \$_POST); include('install.php');" "$post_string"

# Workaround - the above step appears to create root-owned temp directories
chown -R www-data:www-data /var/www/html/piwigo/_data
