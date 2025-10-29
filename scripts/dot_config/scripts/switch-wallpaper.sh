#!/bin/bash

wallpaper="$HOME/.local/share/backgrounds/background"
if [ -e $1 ]; then
    cp "$1" $wallpaper
    $HOME/.config/scripts/flash-swww-wallpaper.sh
fi
