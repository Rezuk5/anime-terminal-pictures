#!/usr/bin/env bash

#########################################
# PROJECT
#########################################

LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$LIB_DIR/../.." && pwd)"

#########################################
# PATHS
#########################################

TXT_DB="$PROJECT_DIR/data/dataPictures.txt"
ART_DIR="$PROJECT_DIR/AnimePictures"
CUSTOMSET_DIR="$PROJECT_DIR/data/CustomSet"

#########################################
# THEMES
#########################################

MENU_THEME="$PROJECT_DIR/terminalGui/rofi/config-edit1.rasi"
WALL_THEME="$PROJECT_DIR/terminalGui/rofi/config-wallpaper1.rasi"


#########################################
# PYTHON
#########################################

PYTHON="${PYTHON:-python3}"
MAIN="$PROJECT_DIR/main.py"