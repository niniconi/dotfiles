#!/bin/bash
execute_exist ranger
install_config_file "${CONFIG_PATH}/rc.conf" "$HOME/.config/ranger/"
install_config_file "${CONFIG_PATH}/rifle.conf" "$HOME/.config/ranger/"

if [ ! -d ~/.config/ranger/plugins/ranger_devicons ];then
    printf " - ${installing}:ranger devicons\n"
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
fi

printf " - ${tip}:请安装pillow包以用于在ranger中预览图片，使用命令：pip install pillow 或 包管理器安装pillow 包\n"
