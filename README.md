![Docker Image CI](https://github.com/edgd1er/docker-webnut/workflows/Docker%20Image%20CI/badge.svg)

[![Clean workflows](https://github.com/edgd1er/docker-webnut/actions/workflows/clean_workflows.yml/badge.svg)](https://github.com/edgd1er/docker-webnut/actions/workflows/clean_workflows.yml)

Difference from [teknologist's](https://github.com/rshipp/webNUT) version:
- Base image switched to python:3.13-alpine3.23 to reduce image size (≈900 MB → ≈80 MB).
- added actions to build image and publish to docker hub.
- added a health check
- added a persistent /config volume for configuration.

Nut2 has a deprecated dependency on telnetlib; change the dependency to nut2-notl when building.

```
telnetlib — Telnet client
Deprecated since version 3.11, removed in version 3.13.
```

# docker-webNUT

webNUT (UPS network monitoring web ui) dockerized.

More infos on webNUT:  https://github.com/rshipp/webNUT

Set the following environment variables:

**UPS_HOST**    with NUT server host IP  *(default: 127.0.0.1)*

**UPS_PORT**	  with NUT server port  *(default: 3493)*

**UPS_USER**    with NUT server username   *(default: monuser)*

**UPS_PASSWORD**     with NUT server  password   *(default: secret)*




Run with:

> docker run -e UPS_HOST="10.11.12.13"  -e UPS_PORT="3493" -e UPS_USER="monuser" -e UPS_PASSWORD="secret" -p 6543:6543 --mount source=config,target=/config edgd1er/webnut:latest

# Docker-compose

```
services:
  webnut:
    image: edgd1er/webnut:latest
    restart: always
    environment:
      UPS_HOST: "10.11.12.13"
      UPS_PORT: "3493"
      UPS_USER: "monuser"
      UPS_PASSWORD: "secret"
    ports:
     - "6543:6543"
    volumes:
      - config:/config
volumes:
  config:
```
