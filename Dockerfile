# syntax=docker/dockerfile:1
FROM python:3-alpine3.19

LABEL maintainer=edgd1er@hotmail.com
EXPOSE 6543

WORKDIR /app/
#hadolint ignore=DL3018
RUN apk add --no-cache bash git \
    && git clone https://github.com/rshipp/webNUT.git \
    && pip install --no-cache-dir -e webNUT

COPY /docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
