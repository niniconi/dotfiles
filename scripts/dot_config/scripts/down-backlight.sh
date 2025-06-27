#!/bin/bash

if [ $(brightnessctl get) -gt 200 ]
then
    brightnessctl set 5%-
elif [ $(brightnessctl get) -gt 100 ]
then
    brightnessctl  set 2%-
else
    brightnessctl set 2-
fi
