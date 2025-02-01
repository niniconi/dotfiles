#!/bin/bash

if [[ $(gsettings get org.gnome.system.proxy mode) == "'none'" ]]
then
    source ./update-proxy.sh
    gsettings set org.gnome.system.proxy mode "manual"
    hyprctl notify -1 10000 "rgb(ff0000)" "proxy enable"
else
    source ./update-proxy.sh
    gsettings set org.gnome.system.proxy mode "none"
    hyprctl notify -1 10000 "rgb(ff0000)" "proxy disable"
fi
