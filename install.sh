#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

tip="${green}[tip]${plain}"
installing="${green}[installing]${plain}"
installed="${yellow}[installed]${plain}"
error="${red}[error]${plain}"
removed="${yellow}[removed]${plain}"

INSTALL_TIP="make sure you install "
REPOSITORY_NAME="my-conf-file"
NEED_DELETE_REPOSITORY=false

excute_exist(){
    which ${1} > /dev/null 2>&1
    if [ $? == 1 ];then
        echo -e "${error}:${INSTALL_TIP}${1}"
        exit 1
    fi
    echo -e "${installed}:${1}"
}

excute_exist wget
excute_exist git

if [ ! -d "../${REPOSITORY_NAME}" ];then
    NEED_DELETE_REPOSITORY=true
    if [ ! -d "./${REPOSITORY_NAME}" ];then
        git clone "https://github.com/niniconi/${REPOSITORY_NAME}.git"
    fi
    cd "${REPOSITORY_NAME}"
fi

entry_directory(){
    cd ${1}
    source ./install.sh
    cd ..
    echo -e "${installed}:${1} configuration"
}

installNeovimConf(){
    echo -e "${installing}:neovim configuration"
    excute_exist npm
    excute_exist nvim
    entry_directory neovim
}

installZshConf(){
    echo -e "${installing}:zsh configuration"
    excute_exist zsh
    entry_directory zsh
}

installTmuxConf(){
    echo -e "${installing}:tmux configuration"
    excute_exist tmux
    entry_directory tmux
}

installRangerConf(){
    echo -e "${installing}:ranger configuration"
    excute_exist ranger
    entry_directory ranger
}

installTermuxConf(){
    echo -e "${installing}:termux configuration"
    entry_directory termux
}

installKittyConf(){
    echo -e "${installing}:kitty configuration"
    excute_exist kitty
    entry_directory kitty
}

installHyprlandConf(){
    echo -e "${installing}:hyprland configuration"
    excute_exist Hyprland
    entry_directory hyprland
}

rmRepository(){
    if [ $NEED_DELETE_REPOSITORY == true ];then
        cd ..
        if [ -d "./${REPOSITORY_NAME}" ];then
            rm "./${REPOSITORY_NAME}" -rf
            echo -e "${removed}:./${REPOSITORY_NAME}"
        fi
    fi
}

while true
do
    echo -e "${tip}:请输入你想应用的配置文件"
    echo -e "\t1. ${red}n${plain}eovim"
    echo -e "\t2. ${red}z${plain}sh"
    echo -e "\t3. ${red}t${plain}mux"
    echo -e "\t4. ${red}r${plain}anger"
    echo -e "\t5. ${red}a${plain}ll"
    echo -e "\t6. ${red}q${plain}uit"
    echo -e "\t7. ${red}te${plain}rmux"
    echo -e "\t8. ${red}h${plain}yprland"
    echo -e "\t9. ${red}k${plain}itty"
    read -p "Prese input your chose :" install
    if [ $install == "N" ] || [ $install == "n" ];then
        installNeovimConf
        break
    elif [ $install == "TE" ] || [ $install == "te" ];then
        installTermuxConf
        break
    elif [ $install == "Z" ] || [ $install == "z" ];then
        installZshConf
        break
    elif [ $install == "A" ] || [ $install == "a" ];then
        installNeovimConf
        installZshConf
        installTmuxConf
        installRangerConf
        installHyprlandConf
        installKittyConf
        break
    elif [ $install == "T" ] || [ $install == "t" ];then
        installTmuxConf
        break
    elif [ $install == "R" ] || [ $install == "r" ];then
        installRangerConf
        break
    elif [ $install == "K" ] || [ $install == "k" ];then
        installKittyConf
        break
    elif [ $install == "H" ] || [ $install == "h" ];then
        installHyprlandConf
        break
    elif [ $install == "Q" ] || [ $install == "q" ];then
        break
    else
        echo -e "${error}:Unkown input chose"
    fi
done

rmRepository
