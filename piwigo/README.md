# Piwigo Docker Container

A somewhat opinionated Piwigo container.

## Usage

You'll need to specify two things:

* **Port mapping** - Apache on the container is listening on port 80
* **Galleries Volume** - Your galleries folder should be mounted to `/var/www/html/piwigo/galleries`

## Plugins

The following plugins are installed as part of the container:

* video-js v2.9.b
* PHP Captcha v1.0.9
* Better No Right Click v1.2
