#!/bin/bash
echo "user:"$HOME

NEOVIM_PATH="${HOME}/.config/nvim/init.vim"

git clone git@github.com:niniconi/my-conf-file.git

cd my-conf-file
echo $NEOVIM_PATH

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cp ./init.vim $NEOVIM_PATH

cd ..
rm my-conf-file -rf
