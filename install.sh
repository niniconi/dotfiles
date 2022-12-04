#!/bin/bash
echo "[user]:"$HOME

NEOVIM_PATH="${HOME}/.config/nvim"
PKG_LIST="git wget curl htop bottom neofetch zsh lsd"
PKG_MGR="pacman -S"

# install software
sudo ${PKG_MGR} ${PKG_LIST}

# install oh my zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# vim config
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir $NEOVIM_PATH -p
rm $NEOVIM_PATH/init.vim
wget -P $NEOVIM_PATH "https://raw.githubusercontent.com/niniconi/my-conf-file/master/init.vim"
