#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/../lib/config.sh"
source "$SCRIPT_DIR/../lib/functions.sh"

####################################
# Меню Random
####################################

menu() {

cat <<EOF
──────── Random All ────────
🎲 Все папки
──────── Random Set ────────
$(sort_folders_menu)
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

random_folder "$ART_DIR/$choice"