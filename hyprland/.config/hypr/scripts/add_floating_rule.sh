#!/usr/bin/env bash
# ~/.config/hypr/scripts/add_floating_rule.sh
# Adds the active or clicked window to Hyprland's persistent floating rules

RULES_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/rules-floating.conf"

mkdir -p "$(dirname "$RULES_FILE")"
touch "$RULES_FILE"

# Mode: "--pick" / "-p" to interactively select a window via slurp
if [[ "$1" == "--pick" || "$1" == "-p" ]]; then
    if ! command -v slurp >/dev/null 2>&1; then
        command -v notify-send >/dev/null 2>&1 && notify-send -u critical "Hyprland" "slurp is required for pick mode"
        echo "Error: slurp is required for pick mode" >&2
        exit 1
    fi
    if ! command -v jq >/dev/null 2>&1; then
        command -v notify-send >/dev/null 2>&1 && notify-send -u critical "Hyprland" "jq is required for pick mode"
        echo "Error: jq is required for pick mode" >&2
        exit 1
    fi

    POINT=$(slurp -p 2>/dev/null)
    [ -z "$POINT" ] && exit 0
    IFS=',' read -r X Y <<< "$POINT"

    WIN_INFO=$(hyprctl clients -j 2>/dev/null | jq -r --argjson x "$X" --argjson y "$Y" '
      [ .[] | select(.at[0] <= $x and $x <= (.at[0] + .size[0]) and .at[1] <= $y and $y <= (.at[1] + .size[1])) ] | first // empty
    ')
    CLASS=$(echo "$WIN_INFO" | jq -r '.class // empty')
    ADDRESS=$(echo "$WIN_INFO" | jq -r '.address // empty')
else
    # Default: inspect currently active/focused window
    if command -v jq >/dev/null 2>&1; then
        WIN_JSON=$(hyprctl activewindow -j 2>/dev/null)
        CLASS=$(echo "$WIN_JSON" | jq -r '.class // empty')
        ADDRESS=$(echo "$WIN_JSON" | jq -r '.address // empty')
    else
        WIN_TXT=$(hyprctl activewindow 2>/dev/null)
        ADDRESS=$(echo "$WIN_TXT" | awk 'NR==1 {print $2}')
        CLASS=$(echo "$WIN_TXT" | awk '/^[[:space:]]*class:[[:space:]]*/ {sub(/^[[:space:]]*class:[[:space:]]*/, ""); print; exit}')
    fi
fi

if [ -z "$CLASS" ]; then
    command -v notify-send >/dev/null 2>&1 && notify-send -u low "Hyprland" "No valid window found"
    echo "No valid window found" >&2
    exit 1
fi

# Escape regex characters in class name (e.g. dots in org.gnome.Calculator)
ESCAPED_CLASS=$(printf '%s\n' "$CLASS" | sed 's/[.[\*^$()+?{|]/\\&/g')
RULE="windowrulev2 = float, class:^(${ESCAPED_CLASS})$"

# Check if the rule is already in the file
if grep -Fxq "$RULE" "$RULES_FILE" 2>/dev/null; then
    command -v notify-send >/dev/null 2>&1 && notify-send "Hyprland" "Rule already exists for: $CLASS"
    if [ -n "$ADDRESS" ]; then
        hyprctl dispatch setfloating "address:${ADDRESS}" >/dev/null 2>&1
    fi
    exit 0
fi

# 1. Immediately float the window in current session
if [ -n "$ADDRESS" ]; then
    hyprctl dispatch setfloating "address:${ADDRESS}" >/dev/null 2>&1
fi

# 2. Register rule in running Hyprland instance dynamically
hyprctl keyword windowrulev2 "float, class:^(${ESCAPED_CLASS})$" >/dev/null 2>&1

# 3. Append to persistent rules file
echo "$RULE" >> "$RULES_FILE"

command -v notify-send >/dev/null 2>&1 && notify-send "Hyprland" "Added persistent floating rule for:\n$CLASS"
