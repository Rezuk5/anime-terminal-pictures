#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../lib/config.sh"
source "$SCRIPT_DIR/../lib/functions.sh"

CUSTOM_DIR="/home/Rezuk/dev/terminalPictures/data/CustomSet"

####################################
# Список папок
####################################

folder=$(
{
    sort_folders_menu

    if [[ -d "$CUSTOM_DIR" ]]; then
        find "$CUSTOM_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort
    fi
} | awk '!seen[$0]++' | rofi \
    -dmenu \
    -i \
    -config "$MENU_THEME" \
    -mesg "🎨 Name Presets"
)

[[ -z "$folder" ]] && exit 0

####################################
# Определяем путь
####################################

if [[ -d "$ART_DIR/$folder" ]]; then
    FULL="$ART_DIR/$folder"
elif [[ -d "$CUSTOM_DIR/$folder" ]]; then
    FULL="$CUSTOM_DIR/$folder"
else
    exit 1
fi

####################################
# Меню имен
####################################

name=$(
    names_in_folder "$FULL" | rofi \
        -dmenu \
        -i \
        -config "$MENU_THEME" \
        -mesg "Choose preset"
)

[[ -z "$name" ]] && exit 0

####################################
# Применить
####################################

python3 /home/Rezuk/dev/terminalPictures/main.py \
    setUserMod \
    "$FULL" \
    "$name"