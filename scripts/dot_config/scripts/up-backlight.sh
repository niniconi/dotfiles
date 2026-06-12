#!/bin/bash

val=$(brightnessctl get)
if [ "$val" -lt 100 ]; then
    brightnessctl set 2%+
elif [ "$val" -lt 200 ]; then
    brightnessctl set 5%+
else
    brightnessctl set 2+
fi
