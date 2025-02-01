#!/bin/bash
execute_exist Hyprland hyprpaper
install_config_file "${CONFIG_PATH}/hyprland.conf" "$HOME/.config/hypr"
install_config_dir "${CONFIG_PATH}/hyprpaper.conf" "$HOME/.config/hypr"
install_config_dir "${CONFIG_PATH}/hyprlock.conf" "$HOME/.config/hypr"
