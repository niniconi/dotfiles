#!/bin/bash
mkdir ~/.config/nvim -p
cp ./init.vim ~/.config/nvim/init.vim
rm ~/.config/nvim/lua -rf
rm ~/.config/nvim/snapshots -rf
cp ./lua ~/.config/nvim/lua -r
cp ./snapshots ~/.config/nvim/snapshots -r
