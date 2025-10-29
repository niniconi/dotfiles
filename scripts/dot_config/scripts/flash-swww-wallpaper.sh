#!/bin/bash
wallpaper="$HOME/.local/share/backgrounds/background"
blur_wallpaper="$HOME/.local/share/backgrounds-blur/background-blur"

$HOME/.config/scripts/image-tool blur 30 $wallpaper $blur_wallpaper
swww img --namespace background --transition-type center --transition-pos 0,0 --transition-step 90 $wallpaper
swww img --namespace backdrop --transition-type center --transition-pos 0,0 --transition-step 90 $blur_wallpaper
