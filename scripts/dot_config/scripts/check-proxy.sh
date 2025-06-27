#!/bin/bash

stat=""

if [[ $(gsettings get org.gnome.system.proxy mode) == "'none'" ]]
then
    stat="disconnected"
else
    stat="connected"
fi

printf '{"alt": "%s", "class": "%s"}' "$stat" "$stat"
