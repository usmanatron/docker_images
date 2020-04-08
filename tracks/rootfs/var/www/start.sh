#!/bin/sh
bundle exec rake db:migrate RAILS_ENV=production
bundle exec puma -e production -b unix:///run/tracks.sock
