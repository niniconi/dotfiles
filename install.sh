#!/bin/bash

INSTALL_TIP="make sure you install "

which wget > /dev/null 2>&1
if [ $? == 1 ];then
    echo "[error]:${INSTALL_TIP}wget"
    exit 1
fi

if [ ! -d "./my-conf-file" ];then
    git clone https://github.com/niniconi/my-conf-file.git
fi
cd my-conf-file

installNeovimConf(){
    echo "[installing]:neovim configuration"
    which nvim > /dev/null 2>&1
    if [ $? == 1 ];then
        echo "[error]:${INSTALL_TIP}neovim"
        exit 1
    fi
    cd neovim
    bash ./install.sh
    cd ..
}

installZshConf(){
    echo "[installing]:zsh configuration"
    which zsh > /dev/null 2>&1
    if [ $? == 1 ];then
        echo "[error]:${INSTALL_TIP}zsh"
        exit 1
    fi
    cd zsh
    bash ./install.sh
    cd ..
}

rmRepository(){
    cd ..
    if [ -d "./my-conf-file" ];then
        rm ./my-conf-file -rf
        echo "[removed]:./my-conf-file"
    fi
}

while true
do
    read -p "Plese input your chose (neovim/zsh/all/quit)[N/Z/A/Q]:" install
    if [ $install == "N" ] || [ $install == "n" ];then
        installNeovimConf
        rmRepository
        break
    elif [ $install == "Z" ] || [ $install == "z" ];then
        installZshConf
        rmRepository
        break
    elif [ $install == "A" ] || [ $install == "a" ];then
        installNeovimConf
        installZshConf
        rmRepository
        break
    elif [ $install == "Q" ] || [ $install == "q" ];then
        rmRepository
        exit 0
    else
        echo "[error]:Unkown input chose"
    fi
done
