#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../lib/config.sh"
source "$SCRIPT_DIR/../lib/functions.sh"

####################################
# Меню выбора папки
####################################

folder=$(
cat <<EOF
$(sort_folders_menu)
EOF
)

folder=$(printf "%s" "$folder" | rofi \
    -dmenu \
    -i \
    -config "$MENU_THEME" \
    -mesg "📂 Choose folder")

[[ -z "$folder" ]] && exit 0

FULL="$ART_DIR/$folder"

####################################
# Старое меню с превью
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