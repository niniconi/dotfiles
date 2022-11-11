#!/bin/bash
echo "user:"$HOME

NEOVIM_PATH="${HOME}/.config/nvim/init.vim"

git clone git@github.com:niniconi/my-conf-file.git

cd my-conf-file
echo $NEOVIM_PATH

cp ./init.vim $NEOVIM_PATH

cd ..
rm my-conf-file -rf
