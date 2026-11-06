#!/bin/sh
set -e
if [ -z "$UUID" ]; then echo "UUID env var is required" >&2; exit 1; fi
WS_PATH="${WS_PATH:-/ws}"
PORT="${PORT:-10000}"
printf '%s' "{\"log\":{\"loglevel\":\"warning\"},\"inbounds\":[{\"listen\":\"0.0.0.0\",\"port\":${PORT},\"protocol\":\"vless\",\"settings\":{\"clients\":[{\"id\":\"${UUID}\"}],\"decryption\":\"none\"},\"streamSettings\":{\"network\":\"ws\",\"security\":\"none\",\"wsSettings\":{\"path\":\"${WS_PATH}\"}}}],\"outbounds\":[{\"protocol\":\"freedom\"}]}" > /config.json
exec /usr/local/bin/xray run -config /config.json
