# syntax=docker/dockerfile:1
FROM python:3-alpine3.20

LABEL maintainer=edgd1er@hotmail.com
EXPOSE 6543

WORKDIR /app/
#hadolint ignore=DL3018
RUN adduser -D user && apk add --no-cache bash git curl \
    && git clone https://github.com/rshipp/webNUT.git \
    && pip install --no-cache-dir -e webNUT \
    && echo "alias checkhealth='curl -f http://localhost:6543 || exit 1'" >>/home/user/.bashrc \
    && chown user:users /home/user/.bashrc

COPY --chown=user --chmod=555  docker-entrypoint.sh /docker-entrypoint.sh

RUN touch /app/webNUT/webnut/config.py && chown user /app/webNUT/webnut/config.py

HEALTHCHECK --interval=30s --timeout=10s --retries=5 CMD curl -f http://localhost:6543 || exit 1

USER user
ENTRYPOINT ["/docker-entrypoint.sh"]
