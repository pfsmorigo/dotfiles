#!/usr/bin/env bash

SPECIAL_NAME="$1"
TARGET_URL="$2"

# 1. Toggle visibility of the special workspace
hyprctl dispatch togglespecialworkspace "$SPECIAL_NAME"

# 2. Check if a window already exists inside this special workspace
HAS_CLIENTS=$(hyprctl clients -j | jq --arg ws "special:$SPECIAL_NAME" '
  [ .[] | select(.workspace.name == $ws) ] | length
')

# 3. If empty, launch the browser directly inside the special workspace with the URL
if [ "$HAS_CLIENTS" -eq 0 ]; then
	hyprctl dispatch exec "[workspace special:$SPECIAL_NAME; float; size 75% 75%; center] google-chrome-stable --app=\"$TARGET_URL\""
fi
