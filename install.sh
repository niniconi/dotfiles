#!/bin/bash

INSTALL_TIP="make sure you install "

which wget > /dev/null 2>&1
if [ $? == 1 ];then
    echo "[error]:${INSTALL_TIP}wget and git"
    exit 1
fi
which git > /dev/null 2>&1
if [ $? == 1 ];then
    echo "[error]:${INSTALL_TIP}wget and git"
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

instalTmuxConf(){
    echo "[installing]:tmux configuration"
    which tmux > /dev/null 2>&1
    if [ $? == 1];then
        echo "[error]:${INSTALL_TIP}tmux"
        exit 1
    fi
    cd tmux
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
    read -p "Plese input your chose (neovim/zsh/tmux/all/quit)[N/Z/T/A/Q]:" install
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
    elif [ $install == "T" ] || [ $install == "t" ];then
        installTmuxConf
        rmRepository
        break
    elif [ $install == "Q" ] || [ $install == "q" ];then
        rmRepository
        exit 0
    else
        echo "[error]:Unkown input chose"
    fi
done
