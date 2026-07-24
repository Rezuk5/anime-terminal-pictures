#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../lib/config.sh"
source "$SCRIPT_DIR/../lib/functions.sh"

CUSTOM_DIR="/home/Rezuk/dev/terminalPictures/data/CustomSet"

####################################
# Меню Random
####################################

menu() {

cat <<EOF
──────── Random All ────────
🎲 Все папки
──────── Random Set ────────
$(
{
    sort_folders_menu

    if [[ -d "$CUSTOM_DIR" ]]; then
        find "$CUSTOM_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort
    fi
} | awk '!seen[$0]++'
)
EOF

}

choice=$(
menu | rofi \
    -dmenu \
    -i \
    -config "$MENU_THEME" \
    -mesg "Choose random mode"
)

[[ -z "$choice" ]] && exit 0

####################################
# Все папки
####################################

if [[ "$choice" == "🎲 Все папки" ]]; then
    random_all
    exit 0
fi

####################################
# Одна папка
####################################

if [[ -d "$ART_DIR/$choice" ]]; then
    random_folder "$ART_DIR/$choice"
elif [[ -d "$CUSTOM_DIR/$choice" ]]; then
    random_folder "$CUSTOM_DIR/$choice"
fi