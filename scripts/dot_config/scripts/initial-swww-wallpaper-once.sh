#!/bin/bash

cache_path=""
monitor_name=`hyprctl monitors | grep Monitor | awk '{ print $2 }'`

if [ -n "${XDG_CACHE_HOME+x}" ]; then
    cache_path="${XDG_CACHE_HOME}/swww/${monitor_name}"
elif [ -n "${HOME+x}" ]; then
    cache_path="${HOME}/.cache/swww/${monitor_name}"
fi

if [ ! -e $cache_path ];then
    swww img --transition-type center --transition-pos 0,0 --transition-step 90 $1
fi
