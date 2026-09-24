#!/usr/bin/env bash

WORKSPACE="$1"
shift

# Check if any client exists on this workspace (matches "www", "name:www", or ID)
HAS_CLIENTS=$(hyprctl clients -j | jq --arg ws "$WORKSPACE" '
  [ .[] | select(.workspace.name == $ws or .workspace.name == ("name:" + $ws) or (.workspace.id | tostring) == $ws) ] | length
')

# Switch to the workspace (Hyprland requires "name:WORKSPACE" for named workspaces)
if [[ "$WORKSPACE" =~ ^[0-9]+$ ]]; then
    hyprctl dispatch workspace "$WORKSPACE"
else
    hyprctl dispatch workspace "name:$WORKSPACE"
fi

# Run only if there are 0 windows on that workspace
if [ "$HAS_CLIENTS" -eq 0 ]; then
    hyprctl dispatch exec "$*"
fi
