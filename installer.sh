#!/bin/bash

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


################################################################################################## FILE & FOLDER PATHS

# Location
APPLICATION="arch-suite"
BASE="$HOME/bash.$APPLICATION"
FILES="$BASE/files"


################################################################################################## INSTALLATION

install_grub_theme() {
    BASE_THEME_DIR="$BASEDIR/files/configurations/theming/grub/qndwm"
    GRUB_THEME_DIR="/boot/grub/themes"
    RESOLUTIONS=("1920x1080" "2560x1440" "3840x2160")
    SELECTED_RESOLUTION=""

    for res in "${RESOLUTIONS[@]}"; do
        if xrandr | grep -q "$res"; then
            SELECTED_RESOLUTION="$res"
            break
        fi
    done

    if [[ -z "$SELECTED_RESOLUTION" ]]; then
        echo "No supported resolution found. Exiting."
        return 1
    fi

    THEME_SOURCE="$BASE_THEME_DIR/$SELECTED_RESOLUTION"

    if [[ ! -d "$THEME_SOURCE" ]]; then
        echo "Theme folder for resolution $SELECTED_RESOLUTION not found. Exiting."
        return 1
    fi

    cp -r "$THEME_SOURCE" "$GRUB_THEME_DIR/"
    echo "GRUB_THEME=\"${GRUB_THEME_DIR}/$SELECTED_RESOLUTION/theme.txt\"" >> /etc/default/grub
    update-grub

    echo "Theme for resolution $SELECTED_RESOLUTION installed successfully."
}
