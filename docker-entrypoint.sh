#!/usr/bin/env bash
set -u -e -o pipefail

upshost="${UPS_HOST:-127.0.0.1}"
upsport="${UPS_PORT:-3493}"
upsuser="${UPS_USER:-monuser}"
upspassword="${UPS_PASSWORD:-secret}"
exported_config=/config/config.py

if  [[ -L /config/config.py ]]; then
  rm -f ${exported_config}
  touch ${exported_config}
fi

echo "server = '${upshost}'
port = '${upsport}'
username = '${upsuser}'
password = '${upspassword}'" > ${exported_config}

while true; do
  res="$(curl -m2 -v telnet://${upshost}:${upsport} 2>&1)" || true
  if [[ $res =~ [Cc]onnected ]]; then
    break
    else echo "Waiting, cannot connect to ${upshost}:${upsport}"
  fi
  sleep 1
done

cd /app/webNUT/webnut
echo "Connecting to ${upsuser}@${upshost}:${upsport}"
exec pserve /app/webNUT/production.ini
