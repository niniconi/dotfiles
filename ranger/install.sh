#!/bin/bash
mkdir ~/.config/ranger -p
cp ./rc.conf ~/.config/ranger/
cp ./rifle.conf ~/.config/ranger/

if [ ! -d "~/.config/ranger/plugins/ranger_devicons" ];then
    echo -e "${installing}:ranger devicons"
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
fi
