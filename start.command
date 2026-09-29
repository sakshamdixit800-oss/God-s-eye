#!/bin/bash
set -e

cd "$(dirname "$0")"
PORT="${GODS_EYE_PORT:-8765}"
URL="http://127.0.0.1:${PORT}/"

python3 -m http.server "$PORT" --bind 127.0.0.1 --directory . >/tmp/gods-eye-server.log 2>&1 &
SERVER_PID=$!
trap 'kill "$SERVER_PID" 2>/dev/null || true' EXIT INT TERM

sleep 1
open "$URL"
printf "God's Eye is running at %s\nPress Ctrl+C to stop.\n" "$URL"
wait "$SERVER_PID"
