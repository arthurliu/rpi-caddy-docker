#!/bin/bash

set -e

if [ "$1" = 'caddy' ]; then
	# we need to set the permissions here because docker mounts volumes as root
	chown -R caddy:caddy /var/lib/caddy

	chmod -R 0770 /var/lib/caddy

	chmod 664 /var/lib/caddy/Caddyfile

	exec gosu caddy "$@"
fi

exec "$@"
