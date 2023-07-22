#!/bin/bash

ZSHRC=~/.zshrc

#install oh my zsh
if [ ! -d ~/.oh-my-zsh ];then
    echo -e "${installing}:oh my zsh"
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
fi

##install some plugins
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ];then
   git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo -e "${installed}:already install zsh-autosuggestions"
fi
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ];then
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
   echo -e "${installed}:already install zsh-syntax-highlighting"
fi

## wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf 
## wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf 
## wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf 
## wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf 
if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ];then
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
   echo -e "${installed}:already install powerlevel10k"
fi

read -p "Please input your editor's command (nvim/vim/vi/others..):" editor
echo "${editor} is your editor"

echo "EDITOR=${editor}" > $ZSHRC
cat .zshrc >> $ZSHRC
rm ${ZSHRC}_command -f
rm ${ZSHRC}_alias -f
cp .zshrc_command ~/
cp .zshrc_alias ~/

echo -e "${tip}:最好安装powerlevel10k专用的字体，相关说明在https://github.com/romkatv/powerlevel10k"
cp ./font-powerlevel10k/ ../../ -r
