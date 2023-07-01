#!/bin/bash

echo -e "${tip}:请安装pillow包以用于在ranger中预览图片，使用命令：pip install pillow 或 包管理器安装pillow 包"

mkdir ~/.config/ranger -p
cp ./rc.conf ~/.config/ranger/
cp ./rifle.conf ~/.config/ranger/

if [ ! -d ~/.config/ranger/plugins/ranger_devicons ];then
    echo -e "${installing}:ranger devicons"
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
fi
