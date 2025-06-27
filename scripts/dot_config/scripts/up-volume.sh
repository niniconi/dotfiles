#!/bin/bash

if [[ $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTE) ]];then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
fi
wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
