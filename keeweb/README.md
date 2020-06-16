# Keeweb

A fairly simple HTTP-only keeweb container. Makes it easy to add your own config file

## Usage

See the included docker-compose file for more details on exact invocation.  Specifically you have to specify a port and (optionally) mount  config file at `/var/www/config.json`.

## Notes

Bear in mind this is HTTP only - you should really add a reverse proxy or similar in front!
