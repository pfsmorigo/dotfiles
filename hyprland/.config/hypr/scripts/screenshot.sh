#!/usr/bin/env bash
# ~/.config/hypr/scripts/screenshot.sh
# Takes screenshots in Hyprland using grim and slurp, saves to disk, and copies to clipboard

MODE="fullscreen"

for arg in "$@"; do
    case "$arg" in
        --area|-a|--region|-r|area)
            MODE="area"
            ;;
        --window|-w|window)
            MODE="window"
            ;;
        --fullscreen|-f|fullscreen)
            MODE="fullscreen"
            ;;
    esac
done

# Ensure grim is available
if ! command -v grim >/dev/null 2>&1; then
    command -v notify-send >/dev/null 2>&1 && notify-send -u critical -a "Hyprland" "Screenshot Failed" "grim is required but not installed."
    echo "Error: grim is required but not installed." >&2
    exit 1
fi

# Resolve screenshot directory
if [ -z "$XDG_PICTURES_DIR" ] && command -v xdg-user-dir >/dev/null 2>&1; then
    XDG_PICTURES_DIR=$(xdg-user-dir PICTURES)
fi
TARGET_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
mkdir -p "$TARGET_DIR"

FILENAME="screenshot_$(date +'%F_%H-%M-%S').png"
FILEPATH="${TARGET_DIR}/${FILENAME}"

case "$MODE" in
    area)
        if ! command -v slurp >/dev/null 2>&1; then
            command -v notify-send >/dev/null 2>&1 && notify-send -u critical -a "Hyprland" "Screenshot Failed" "slurp is required for area selection."
            echo "Error: slurp is required for area selection." >&2
            exit 1
        fi

        GEOM=$(slurp 2>/dev/null)
        if [ -z "$GEOM" ]; then
            # Selection was cancelled by user
            exit 0
        fi

        grim -g "$GEOM" "$FILEPATH"
        ;;
    window)
        GEOM=""
        if command -v jq >/dev/null 2>&1 && command -v hyprctl >/dev/null 2>&1; then
            GEOM=$(hyprctl activewindow -j 2>/dev/null | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' 2>/dev/null)
        fi

        if [ -n "$GEOM" ] && [ "$GEOM" != "null,null nullxnull" ]; then
            grim -g "$GEOM" "$FILEPATH"
        else
            grim "$FILEPATH"
        fi
        ;;
    fullscreen|*)
        grim "$FILEPATH"
        ;;
esac

# Verify capture succeeded
if [ ! -s "$FILEPATH" ]; then
    exit 1
fi

# Copy to clipboard if wl-copy is installed
if command -v wl-copy >/dev/null 2>&1; then
    wl-copy --type image/png < "$FILEPATH"
fi

# Send notification if notify-send is installed
if command -v notify-send >/dev/null 2>&1; then
    notify-send -i "$FILEPATH" -a "Hyprland" "Screenshot Captured" "Saved to ${FILENAME} and copied to clipboard."
fi
