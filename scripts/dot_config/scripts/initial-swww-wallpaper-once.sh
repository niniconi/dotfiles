#!/bin/bash

cache_path=""
if [ -n "${XDG_CACHE_HOME+x}" ]; then
    cache_path="${XDG_CACHE_HOME}/swww"
elif [ -n "${HOME+x}" ]; then
    cache_path="${HOME}/.cache/swww"
fi

if [ ! -n "${cache_path}" ];then
    swww img --transition-type center --transition-pos 0,0 --transition-step 90 $1
fi
