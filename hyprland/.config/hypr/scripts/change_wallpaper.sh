#!/usr/bin/env bash

WALLPAPER_DIRS=(
    "$HOME/Pictures/Wallpapers"
    "$HOME/Pictures/Wallpapers-Landscape"
    "/usr/share/backgrounds"
)

# If an image path is passed as argument, use it; otherwise pick a random one
if [ -n "$1" ] && [ -f "$1" ]; then
    WALLPAPER="$1"
else
    WALLPAPER=$(find "${WALLPAPER_DIRS[@]}" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) 2>/dev/null | shuf -n 1)
fi

[ -z "$WALLPAPER" ] && { echo "No wallpaper found."; exit 1; }

# Ensure hyprpaper is running
if ! pgrep -x hyprpaper > /dev/null; then
    touch "$HOME/.config/hypr/hyprpaper.conf"
    hyprpaper &
    sleep 0.5
fi

# Preload target image
hyprctl hyprpaper preload "$WALLPAPER"

# Detect all active monitors
if command -v jq >/dev/null 2>&1; then
    MONITORS=$(hyprctl monitors -j | jq -r '.[].name')
else
    MONITORS=$(hyprctl monitors | awk '/^Monitor/ {print $2}')
fi

# Apply to every connected monitor
for MON in $MONITORS; do
    hyprctl hyprpaper wallpaper "${MON},${WALLPAPER}"
done

# Cleanup memory
sleep 1
hyprctl hyprpaper unload unused 2>/dev/null || true

