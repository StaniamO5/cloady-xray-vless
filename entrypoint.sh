#!/bin/sh
set -eu
# UUID and WS_PATH are provided only as Cloady environment variables.
: "${UUID:?UUID environment variable is required}"
: "${WS_PATH:?WS_PATH environment variable is required}"
mkdir -p /etc/xray
cat > /etc/xray/config.json <<EOF
{
  "log": {"loglevel": "warning"},
  "inbounds": [
    {
      "port": 3000,
      "protocol": "vless",
      "settings": {
        "clients": [{"id": "${UUID}", "flow": ""}],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {"path": "${WS_PATH}"}
      }
    }
  ],
  "outbounds": [
    {"protocol": "freedom", "tag": "direct"},
    {"protocol": "blackhole", "tag": "blocked"}
  ]
}
EOF
exec /usr/local/bin/xray run -config /etc/xray/config.json































