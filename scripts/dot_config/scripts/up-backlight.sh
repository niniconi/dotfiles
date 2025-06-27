#!/bin/bash

if [ $(brightnessctl get) -lt 200 ]
then
    brightnessctl set 5%+
elif [ $(brightnessctl get) -lt 100 ]
then
    brightnessctl  set 2%+
else
    brightnessctl set 2+
fi
