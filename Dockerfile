# syntax=docker/dockerfile:1
FROM python:3-alpine3.20

LABEL maintainer=edgd1er@hotmail.com
EXPOSE 6543

WORKDIR /app/
#hadolint ignore=DL3018
RUN adduser -D user && apk add --no-cache bash git curl \
    && git clone https://github.com/rshipp/webNUT.git \
    && pip install --no-cache-dir -e webNUT \
    && mkdir /config && touch /config/config.py && chown user:users /config/config.py /config \
    && echo "alias checkhealth='curl -f http://localhost:6543 || exit 1'" >>/home/user/.bashrc \
    && chown user:users /home/user/.bashrc

COPY --chown=user --chmod=555  docker-entrypoint.sh /docker-entrypoint.sh

RUN ln -sf /config/config.py /app/webNUT/webnut/config.py

VOLUME /config

HEALTHCHECK --interval=10s --timeout=10s --retries=5 CMD curl -f http://0.0.0.0:6543 2>&1 || exit 1

USER user
ENTRYPOINT ["/docker-entrypoint.sh"]
