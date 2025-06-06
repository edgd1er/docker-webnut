![Docker Image CI](https://github.com/edgd1er/docker-webnut/workflows/Docker%20Image%20CI/badge.svg)

Difference from [teknologist's](https://github.com/rshipp/webNUT) version:
- switch to python3-alpine3.20 as base image to reduce image size (900Mb -> 80Mb)
- added actions to build image and publish to docker hub.
- add health check
- add volume /config to persist config.

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
