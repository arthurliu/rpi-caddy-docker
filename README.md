# YADC for ARM architecture (Raspberry Pi et al.)

```
**** **** **** **** ****
    WORK-IN-PROGRESS
**** **** **** **** ****
```

Yet Another Dockerized Caddy HTTP/2 web server – **but for ARM architecture**.

Put the caddy in a docker container and ship it anywhere **w/ your ARM architecture device, e.g. Raspberry Pi**.

Build and tested on *Raspberry Pi 3 Model B* (`ARMv8`).

## Available tags

- `latest`, `0.10.14`: Caddy v0.10.14
- `0.10.2`: Caddy v0.10.2

## Features

- built on top of the solid and small `resin/rpi-raspbian:jessie` base image
- exposes Caddy on ports `80` and `443` and Caddy's default `2015` of the container
- runs everything as user `caddy` (security ftw!)

## Run 0.10.14/ latest

Available on the docker registry as [matthiasg/rpi-caddy:latest](https://index.docker.io/u/matthiasg/rpi-caddy/).

This is a build of the Caddy v0.10.14 release.

A data volume is exposed on /opt/caddy/data, and the node's ports are exposed on `80` and `443`.

```
# expose it to the world on ports 80 and 443 and use your current directory as the Caddy data directory
[sudo] docker run -p 80:80 -p 443:443 -v $(pwd):/var/lib/caddy matthiasg/rpi-caddy
[...]
```

## Build your own

You can use `matthiasg/rpi-caddy` as the base image for your own Caddy web server instance.

You might want to provide your own version of the following files:

* `Caddyfile` for your custom Caddy config

Example Dockerfile:

```
FROM matthiasg/rpi-caddy:latest

COPY Caddyfile /var/lib/caddy/
```

and then build and run

```
[sudo] docker build -t you/awesome-caddy .
[sudo] docker run -d -p 80:80 -p 443:443 -v ~/caddy:/var/lib/caddy you/awesome-caddy
```

## Feedback, Issues, Contributing

Please use Github issues for any questions, bugs, feature requests. :) I don't get notified about comments on Docker Hub, so I might respond really late...or not at all.

## Credits, Attribution, THANK YOU and ❤

[Matt Holt](https://github.com/mholt) and [all the fine people contributing](https://github.com/mholt/caddy/graphs/contributors) to the AWESOME Caddy server project.