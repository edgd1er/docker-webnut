#!/usr/bin/env bash
set -u -e -o pipefail

upshost="${UPS_HOST:-127.0.0.1}"
upsport="${UPS_PORT:-3493}"
upsuser="${UPS_USER:-monuser}"
upspassword="${UPS_PASSWORD:-secret}"

echo "server = '$upshost'" > /app/webNUT/webnut/config.py
echo "port = '$upsport'" >> /app/webNUT/webnut/config.py
echo "username = '$upsuser'" >> /app/webNUT/webnut/config.py
echo "password = '$upspassword'" >> /app/webNUT/webnut/config.py

cd /app/webNUT/webnut
echo "Connecting to ${upsuser}@${upshost}:${upsport}"

exec pserve ../production.ini
