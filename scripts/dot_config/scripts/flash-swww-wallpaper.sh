#!/bin/bash

$HOME/.config/scripts/image-tool blur 30 $HOME/.config/background $HOME/.config/background-blur
swww img --namespace background --transition-type center --transition-pos 0,0 --transition-step 90 $HOME/.config/background
swww img --namespace backdrop --transition-type center --transition-pos 0,0 --transition-step 90 $HOME/.config/background-blur
