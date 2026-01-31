#!/bin/bash

#install oh my zsh
if [ ! -d ~/.oh-my-zsh ];then
    printf " - ${installing}:oh my zsh\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
