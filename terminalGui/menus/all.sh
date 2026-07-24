#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../lib/config.sh"
source "$SCRIPT_DIR/../lib/functions.sh"

####################################
# Все арты
####################################

img=$(
    all_arts_menu | rofi \
        -dmenu \
        -i \
        -show-icons \
        -lines 4 \
        -config "$WALL_THEME"
)

[[ -z "$img" ]] && exit 0

picture=$(find_image_in_db "$img")

[[ -z "$picture" ]] && exit 0

set_picture "$picture"