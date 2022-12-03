#!/bin/bash
echo "[user]:"$HOME

NEOVIM_PATH="${HOME}/.config/nvim"
PKG_LIST="git wget curl htop exa bottom neofetch"
PKG_MGR="pacman -S"

# install software
sudo ${PKG_MGR} ${PKG_LIST}

# vim config
mkdir $NEOVIM_PATH -p
rm $NEOVIM_PATH/init.vim
wget -P $NEOVIM_PATH "https://raw.githubusercontent.com/niniconi/my-conf-file/master/init.vim"
