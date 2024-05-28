# syntax=docker/dockerfile:1
FROM python:3-alpine3.20

LABEL maintainer=edgd1er@hotmail.com
EXPOSE 6543

WORKDIR /app/
#hadolint ignore=DL3018
RUN adduser -D user && apk add --no-cache bash git \
    && git clone https://github.com/rshipp/webNUT.git \
    && pip install --no-cache-dir -e webNUT

COPY --chown=user --chmod=555  docker-entrypoint.sh /docker-entrypoint.sh

RUN touch /app/webNUT/webnut/config.py && chown user /app/webNUT/webnut/config.py

USER user
ENTRYPOINT ["/docker-entrypoint.sh"]
