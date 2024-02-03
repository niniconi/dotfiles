#!/bin/bash

execute_exist zsh git

#install oh my zsh
if [ ! -d ~/.oh-my-zsh ];then
    printf " - ${installing}:oh my zsh\n"
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
fi


# install some plugins
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ];then
   git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    printf " - ${installed}:already install zsh-autosuggestions\n"
fi
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ];then
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
   printf " - ${installed}:already install zsh-syntax-highlighting\n"
fi


# install some themes
if [ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ];then
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
   printf " - ${installed}:already install powerlevel10k\n"
fi


# set editor
while true
do
    read -p "Please input your editor's command (nvim/vim/vi/others..):" editor

    which ${editor} > /dev/null 2>&1
    if [ $? == 1 ];then
        printf "${bold}${red}${editor}${plain} is not a available command\n"
    else
        printf "${bold}${green}${editor}${plain} is your editor\n"
        break
    fi
done

ZSHRC=~/.zshrc

echo "EDITOR=${editor}" > $ZSHRC
cat ${CONFIG_PATH}/.zshrc >> $ZSHRC
rm ${ZSHRC}_command -f
rm ${ZSHRC}_alias -f
cp ${CONFIG_PATH}/.zshrc_command ~/
cp ${CONFIG_PATH}/.zshrc_alias ~/

printf " - ${tip}:最好安装powerlevel10k专用的字体，相关说明在https://github.com/romkatv/powerlevel10k\n"
printf " - ${tip}:需要的字体是nerd-fonts字体,推荐其中的Meslo字体\n"
