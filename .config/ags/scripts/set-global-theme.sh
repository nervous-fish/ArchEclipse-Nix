#!/bin/bash

if [ "$1" ]; then
    ./scripts/system-theme.sh switch $2

    notify-send "Current theme" "$(./scripts/system-theme.sh get)"
fi

./scripts/cursor-theme.sh &

./scripts/wal-theme.sh &
