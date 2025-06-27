#!/bin/bash

stat=""

if [[ ! $(nmcli con show WireGuard | grep GENERAL.STATE) ]]
then
    stat="disconnected"
else
    stat="connected"
fi

printf '{"alt": "%s", "class": "%s"}' "$stat" "$stat"
