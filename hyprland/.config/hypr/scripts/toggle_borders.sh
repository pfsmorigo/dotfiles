#!/usr/bin/env bash
# ~/.config/hypr/scripts/toggle_borders.sh
# Toggle window borders and gaps in Hyprland

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/hypr_borders_disabled"

# Default configuration from hyprland.conf
DEFAULT_BORDER=3
DEFAULT_GAPS_IN=2
DEFAULT_GAPS_OUT=3
DEFAULT_ROUNDING=10

# Alternative configuration (borderless layout)
ALT_BORDER=0
ALT_GAPS_IN=0
ALT_GAPS_OUT="5 0 0 0"

TOGGLE_ROUNDING=0

for arg in "$@"; do
    case "$arg" in
        --rounding|-r) TOGGLE_ROUNDING=1 ;;
        --all|-a) TOGGLE_ROUNDING=1 ;;
    esac
done

# Read current border size from Hyprland
CURRENT_BORDER=$(hyprctl getoption general:border_size 2>/dev/null | awk '/int:/ {print $2}')

if [ "$CURRENT_BORDER" = "$ALT_BORDER" ] || [ -f "$STATE_FILE" ]; then
    # Restore defaults (border_size 3, gaps_in 2, gaps_out 3)
    rm -f "$STATE_FILE"
    CMD="keyword general:border_size $DEFAULT_BORDER ; keyword general:gaps_in $DEFAULT_GAPS_IN ; keyword general:gaps_out $DEFAULT_GAPS_OUT"
    if [ "$TOGGLE_ROUNDING" -eq 1 ]; then
        CMD="$CMD ; keyword decoration:rounding $DEFAULT_ROUNDING"
    fi
else
    # Switch to alternative (border_size 0, gaps_in 0, gaps_out 5 0 0 0)
    touch "$STATE_FILE"
    CMD="keyword general:border_size $ALT_BORDER ; keyword general:gaps_in $ALT_GAPS_IN ; keyword general:gaps_out $ALT_GAPS_OUT"
    if [ "$TOGGLE_ROUNDING" -eq 1 ]; then
        CMD="$CMD ; keyword decoration:rounding 0"
    fi
fi

if command -v hyprctl >/dev/null 2>&1; then
    hyprctl --batch "$CMD" 2>/dev/null || {
        IFS=';' read -ra CMDS <<< "$CMD"
        for c in "${CMDS[@]}"; do
            c_trimmed=$(echo "$c" | xargs)
            [ -n "$c_trimmed" ] && hyprctl $c_trimmed
        done
    }
fi
