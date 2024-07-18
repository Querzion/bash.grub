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
APPLICATION="grub"
BASE="$HOME/bash.$APPLICATION"
FILES="$BASE/files"
# Grub Related
BASE_THEME_DIR="$FILES/theme/qndwm"
GRUB_THEME_DIR="/boot/grub/themes"

################################################################################################## INSTALLATION

install_grub_theme() {
    RESOLUTIONS=("1920x1080" "2560x1440" "3840x2160")
    SELECTED_RESOLUTION=""

    for res in "${RESOLUTIONS[@]}"; do
        if xrandr | grep -q "$res"; then
            SELECTED_RESOLUTION="$res"
            break
        fi
    done

    if [[ -z "$SELECTED_RESOLUTION" ]]; then
        echo -e "${RED} No supported resolution found. Exiting. ${NC}"
        return 1
    fi

    THEME_SOURCE="$BASE_THEME_DIR/$SELECTED_RESOLUTION"

    if [[ ! -d "$THEME_SOURCE" ]]; then
        echo -e "${RED} Theme folder for resolution $SELECTED_RESOLUTION not found. Exiting. ${NC}"
        return 1
    fi

    cp -r "$THEME_SOURCE" "$GRUB_THEME_DIR/"
    echo "GRUB_THEME=\"${GRUB_THEME_DIR}/$SELECTED_RESOLUTION/theme.txt\"" >> /etc/default/grub
    update-grub

    echo -e "${GREEN} Theme for resolution $SELECTED_RESOLUTION installed successfully. ${NC}"
}

echo -e "${GREEN} Installing QnDWM Grub Theme. ${NC}"
install_grub_theme