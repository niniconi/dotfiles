
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

which wget > /dev/null 2>&1
if [ $? == 1 ];then
    echo -e "${error}:${INSTALL_TIP}wget and git"
    exit 1
fi
which git > /dev/null 2>&1
if [ $? == 1 ];then
    echo -e "${error}:${INSTALL_TIP}wget and git"
    exit 1
fi

if [ ! -d "./${REPOSITORY_NAME}" ];then
    git clone "https://github.com/niniconi/${REPOSITORY_NAME}.git"
fi
cd "${REPOSITORY_NAME}"

installNeovimConf(){
    echo -e "${installing}:neovim configuration"
    which nvim > /dev/null 2>&1
    if [ $? == 1 ];then
        echo -e "${error}:${INSTALL_TIP}neovim"
        exit 1
    fi
    cd neovim
    source ./install.sh
    cd ..
}

installZshConf(){
    echo -e "${installing}:zsh configuration"
    which zsh > /dev/null 2>&1
    if [ $? == 1 ];then
        echo -e "${error}:${INSTALL_TIP}zsh"
        exit 1
    fi
    cd zsh
    source ./install.sh
    cd ..
}

installTmuxConf(){
    echo -e "${installing}:tmux configuration"
    which tmux > /dev/null 2>&1
    if [ $? == 1 ];then
        echo -e "${error}:${INSTALL_TIP}tmux"
        exit 1
    fi
    cd tmux
    source ./install.sh
    cd ..
}

installRangerConf(){
    echo -e "${installing}:ranger configuration"
    which ranger > /dev/null 2>&1
    if [ $? == 1 ];then
        echo -e "${error}:${INSTALL_TIP}ranger"
        exit 1
    fi
    cd ranger
    source ./install.sh
    cd ..
}

installTermuxConf(){
    echo -e "${installing}:termux configuration"
    cd termux
    source ./install.sh
    cd ..
}

rmRepository(){
    cd ..
    if [ -d "./${REPOSITORY_NAME}" ];then
        rm "./${REPOSITORY_NAME}" -rf
        echo -e "${removed}:./${REPOSITORY_NAME}"
    fi
}

while true
do
    echo -e "\t1. ${red}n${plain}eovim"
    echo -e "\t2. ${red}z${plain}sh"
    echo -e "\t3. ${red}t${plain}mux"
    echo -e "\t4. ${red}r${plain}anger"
    echo -e "\t5. ${red}a${plain}ll"
    echo -e "\t6. ${red}q${plain}uit"
    echo -e "\t7. ${red}te${plain}rmux"
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
        break
    elif [ $install == "T" ] || [ $install == "t" ];then
        installTmuxConf
        break
    elif [ $install == "R" ] || [ $install == "r" ];then
        installRangerConf
        break
    elif [ $install == "Q" ] || [ $install == "q" ];then
        break
    else
        echo -e "${error}:Unkown input chose"
    fi
done

rmRepository
