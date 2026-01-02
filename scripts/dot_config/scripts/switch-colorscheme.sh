#!/bin/bash

CURRENT_COLOR_SCHEME=`gsettings get org.gnome.desktop.interface color-scheme`

if [[ "$CURRENT_COLOR_SCHEME" == "'prefer-light'" || "$CURRENT_COLOR_SCHEME" == "'default'" ]]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
fi
