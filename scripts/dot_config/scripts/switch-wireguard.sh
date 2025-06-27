#!/bin/bash

if [[ ! $(nmcli con show WireGuard | grep GENERAL.STATE) ]]
then
    nmcli con up WireGuard
    hyprctl notify -1 10000 "rgb(ff0000)" "WireGuard enable"
else
    nmcli con down WireGuard
    hyprctl notify -1 10000 "rgb(ff0000)" "WireGuard disable"
fi
