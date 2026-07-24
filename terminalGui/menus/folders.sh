#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../lib/config.sh"
source "$SCRIPT_DIR/../lib/functions.sh"

CUSTOM_DIR="/home/Rezuk/dev/terminalPictures/data/CustomSet"

####################################
# Меню выбора папки
####################################

folder=$(
{
    sort_folders_menu

    if [[ -d "$CUSTOM_DIR" ]]; then
        find "$CUSTOM_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort
    fi
} | awk '!seen[$0]++'
)

folder=$(printf "%s\n" "$folder" | rofi \
    -dmenu \
    -i \
    -config "$MENU_THEME" \
    -mesg "📂 Choose folder")

[[ -z "$folder" ]] && exit 0

if [[ -d "$ART_DIR/$folder" ]]; then
    FULL="$ART_DIR/$folder"
elif [[ -d "$CUSTOM_DIR/$folder" ]]; then
    FULL="$CUSTOM_DIR/$folder"
else
    exit 1
fi

####################################
# Меню изображений
####################################

img=$(
    images_in_folder "$FULL" | rofi \
        -dmenu \
        -i \
        -show-icons \
        -lines 4 \
        -config "$WALL_THEME"
)

[[ -z "$img" ]] && exit 0

picture=$(find_image_in_folder "$FULL" "$img")

[[ -z "$picture" ]] && exit 0

set_picture "$picture"