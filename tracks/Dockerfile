FROM ruby:2.6.6-alpine3.11

ARG TRACKS_VERSION
ENV RAILS_ENV=production

RUN apk add postgresql-client postgresql-dev nodejs build-base ruby-dev \
            curl unzip supervisor nginx git && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/TracksApp/tracks/archive/v${TRACKS_VERSION}.zip -o tracks.zip && \
    unzip tracks.zip && \
    mv tracks-${TRACKS_VERSION}/* /var/www && \
    rm -rf tracks-${TRACKS_VERSION} && \
    chown -R nginx:nginx /var/www && \
    mkdir -p /run/nginx

# Setup Gemfile
RUN cd /var/www && \
    echo "gem 'pg', '~> 1.2.2'" >> Gemfile && \
    echo "gem 'tzinfo-data'" >> Gemfile

COPY ./rootfs /

# bundle install and precompile
RUN cd /var/www && \
    gem install bundler:2.0.1 && \
    gem install sassc -v '2.0.0' --source 'https://rubygems.org/' && \
    bundle install --without development test mysql sqlite
RUN cd /var/www && \
    bundle exec rake assets:precompile

VOLUME ["/var/www"]
EXPOSE 80


CMD "/usr/bin/supervisord" "-nc" "/etc/supervisor/supervisord.conf"