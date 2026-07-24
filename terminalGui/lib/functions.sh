#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/config.sh"

#########################################
# Все арты
#########################################

all_arts_menu() {

    while IFS= read -r img
    do

        [[ -f "$img" ]] || continue

        printf "%s\x00icon\x1f%s\n" \
            "$(basename "$img")" \
            "$img"

    done < "$TXT_DB"

}

#########################################
# Все папки
#########################################

sort_folders_menu() {

    find "$ART_DIR" \
        -mindepth 1 \
        -maxdepth 1 \
        -type d |
    sort |
    while read -r dir
    do
        basename "$dir"
    done

}

#########################################
# Картинки папки
#########################################

images_in_folder() {

    local folder="$1"

    find "$folder" \
        -maxdepth 1 \
        -type f \
        \( \
            -iname "*.png" \
            -o -iname "*.jpg" \
            -o -iname "*.jpeg" \
            -o -iname "*.webp" \
        \) |
    sort |
    while read -r img
    do

        printf "%s\x00icon\x1f%s\n" \
            "$(basename "$img")" \
            "$img"

    done

}

#########################################
# Меню Random
#########################################

random_menu() {

    printf "🎲 Все папки\n"

    find "$ART_DIR" \
        -mindepth 1 \
        -maxdepth 1 \
        -type d |
    sort |
    while read -r dir
    do
        basename "$dir"
    done

}

#########################################
# Поиск изображения в БД
#########################################

find_image_in_db() {

    local file="$1"

    while IFS= read -r img
    do

        [[ "$(basename "$img")" == "$file" ]] && {

            echo "$img"
            return

        }

    done < "$TXT_DB"

}

#########################################
# Поиск изображения в папке
#########################################

find_image_in_folder() {

    local folder="$1"
    local file="$2"

    find "$folder" \
        -maxdepth 1 \
        -type f \
        \( \
            -iname "*.png" \
            -o -iname "*.jpg" \
            -o -iname "*.jpeg" \
            -o -iname "*.webp" \
        \) |
    while read -r img
    do

        [[ "$(basename "$img")" == "$file" ]] && {

            echo "$img"
            return

        }

    done

}

#########################################
# Выбор картинки
#########################################

set_picture() {

    local file="$1"

    [[ -z "$file" ]] && exit 0

    "$PYTHON" "$MAIN" setPicture "$file"

}

#########################################
# Random по всем папкам
#########################################

random_all() {

    "$PYTHON" "$MAIN" setAllMod

}

#########################################
# Random по одной папке
#########################################

random_folder() {

    local folder="$1"

    "$PYTHON" "$MAIN" setUserMod "$folder"

}