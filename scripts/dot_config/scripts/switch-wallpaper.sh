#!/bin/bash

wallpaper="$HOME/.local/share/backgrounds/background"
if [ -n "$1" ] && [ -e "$1" ]; then
    cp "$1" $wallpaper
    $HOME/.config/scripts/flash-swww-wallpaper.sh
fi
