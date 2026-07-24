#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

choice=$("$SCRIPT_DIR/menus/main.sh")



[[ -z "$choice" ]] && exit 0

case "$choice" in

*"🖼 Все арты"*)
    "$SCRIPT_DIR/menus/all.sh"
    
;;
*"📂 Сортировка"*)
    "$SCRIPT_DIR/menus/folders.sh"
;;
*"🎲 Random Mode"*)
    "$SCRIPT_DIR/menus/random.sh"
;;

esac