#!/bin/bash

# Wait for DB to be ready
/root/wait-for.sh "$PIWIGO_DB_HOST:3306" -t 60 -- echo "Database ready"

# Install
/root/install_piwigo.sh

# Start the site!
apache2-foreground
