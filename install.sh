#!/bin/bash
if [ ! -d "./my-conf-file" ];then
    git clone https://github.com/niniconi/my-conf-file.git
fi
cd my-conf-file

echo "[installing]:neovim configuration"
cd neovim
bash ./install.sh
cd ..

echo "[installing]:zsh configuration"
cd zsh
bash ./install.sh
cd ..

if [ -d "./my-conf-file" ];then
    rm ./my-conf-file
fi
