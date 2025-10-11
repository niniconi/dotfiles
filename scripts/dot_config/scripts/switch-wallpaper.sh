#!/bin/bash

if [ -e $1 ]; then
    cp "$1" $HOME/.config/background
    $HOME/.config/scripts/flash-swww-wallpaper.sh
fi
