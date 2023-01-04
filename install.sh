#!/bin/bash
if [ ! -d "./my-conf-file" ];then
    git clone https://github.com/niniconi/my-conf-file.git
fi
cd my-conf-file

installNeovimConf(){
    echo "[installing]:neovim configuration"
    cd neovim
    bash ./install.sh
    cd ..
}

installZshConf(){
    echo "[installing]:zsh configuration"
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
    read -p "Plese input your chose (neovim/zsh/all)[N/Z/A]:" install
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

