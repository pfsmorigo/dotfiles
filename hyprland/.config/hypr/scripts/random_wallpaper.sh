#!/usr/bin/env bash

WALLPAPER_DIRS=(
    "$HOME/Pictures/Wallpapers"
    "$HOME/Pictures/Wallpapers-Landscape"
    "/usr/share/backgrounds"
)

INTERVAL=600

# Start hyprpaper daemon if not running
if ! pgrep -x hyprpaper > /dev/null; then
    touch "$HOME/.config/hypr/hyprpaper.conf"
    hyprpaper &
    sleep 0.5
fi

while true; do
    WALLPAPER=$(find "${WALLPAPER_DIRS[@]}" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) 2>/dev/null | shuf -n 1)

    if [ -n "$WALLPAPER" ]; then
        # Preload the image
        hyprctl hyprpaper preload "$WALLPAPER"

        # Detect active monitors
        MONITORS=$(hyprctl monitors | awk '/^Monitor/ {print $2}')

        # Pass "MONITOR,PATH" as a single quoted string
        for MON in $MONITORS; do
            hyprctl hyprpaper wallpaper "${MON},${WALLPAPER}"
        done

        sleep 2

        # 'unused' frees previously loaded wallpapers that are no longer displayed
        hyprctl hyprpaper unload unused 2>/dev/null || true
    fi

    sleep "$INTERVAL"
done
