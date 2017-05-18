#!/bin/bash

set -e

if [ "$1" = 'caddy' ]; then
	exec gosu caddy "$@"
fi

exec "$@"
