#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../lib/config.sh"

menu() {

cat <<EOF
🖼 Все арты
📂 Сортировка
🎲 Random Mode
🎲 Name Presets
EOF

}

menu | rofi \
    -i \
    -dmenu \
    -config "$MENU_THEME" \
    -mesg "──────── Wallpaper Manager ────────"