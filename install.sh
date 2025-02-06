#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
bold='\033[1m'
underline='\033[4m'
plain='\033[0m'

tip="${green}[tip]${plain}"
installing="${green}[installing]${plain}"
installed="${yellow}[installed]${plain}"
error="${red}[error]${plain}"
removed="${yellow}[removed]${plain}"

REPOSITORY_NAME="dotfiles"
REPOSITORY_URL="https://github.com/niniconi/${REPOSITORY_NAME}.git"
NEED_DELETE_REPOSITORY=false

REPOSITORY_PATH=""
CONFIG_PATH=""

# get_config_names
CONF_NAMES=()
CONF_IGNORE=(.git README.md install.sh screenshot)

SELECT_INDEX=1

delete_repository(){
    if [ $NEED_DELETE_REPOSITORY == true ];then
        cd ..
        if [ -d "./${REPOSITORY_NAME}" ];then
            rm "./${REPOSITORY_NAME}" -rf
            printf "${removed}:./${REPOSITORY_NAME}\n"
        fi
    fi
}

clear_line(){
    printf "\e[K"
}

reset_cursor(){
    printf "\e[${1}A"
}

clear_screen(){
    for ((i=0;i<${1};i++));do
        printf "\e[1A"
        printf "\e[K"
    done
}

select_panel(){
    select_id=1
    ret_val="0"

    printf "\n"
    printf "j --- roll down\n"
    printf "k --- roll up\n"
    printf "q --- quit\n"
    printf "G --- jump to end option\n"
    printf "$1\n\n"

    prev_cnt=0
    for i in $1;do
        ((prev_cnt++))
    done

    for text in $@;do
        if [ $prev_cnt == 0 ];then
            if [[ "$select_id" == "$SELECT_INDEX" ]];then
                printf "${red}->   (${select_id})  ${underline}${bold}${text}${plain}\n"
            else
                printf "   (${select_id})  ${underline}${bold}${text}${plain}\n"
            fi

            ((select_id++))
        else
            ((prev_cnt--))
        fi
    done

    if (( $SELECT_INDEX == $select_id ));then
        printf "${red}->   (a)  ${underline}${bold}all${plain}\n"
    else
        printf "   (a)  ${underline}${bold}all${plain}\n"
    fi
    if (( $SELECT_INDEX == $select_id+1 ));then
        printf "${red}->   (q)  ${underline}${bold}quit${plain}\n"
    else
        printf "   (q)  ${underline}${bold}quit${plain}\n"
    fi
    printf "\n"

    read -n1 input
    echo -e "\b "
    if [[ $input != "" ]];then
        if [[ $input == "j" ]];then
            ((SELECT_INDEX++))
        elif [[ $input == "k" ]];then
            ((SELECT_INDEX--))
        elif [[ $input == "q" ]];then
            ret_val="254"
        elif [[ $input == "G" ]];then
            ((SELECT_INDEX=select_id+1))
        fi
        if (( $SELECT_INDEX > $select_id + 1 ));then
            ((SELECT_INDEX=1))
        elif (( $SELECT_INDEX == 0 ));then
            ((SELECT_INDEX=select_id+1))
        fi
    else
        if (( $SELECT_INDEX == $select_id ));then
            ret_val="255"
        elif (( $SELECT_INDEX == $select_id + 1 ));then
            ret_val="254"
        else
            ret_val=$SELECT_INDEX
        fi
    fi
    printf "${plain}"

    clear_screen `expr $select_id + 10`
    return $ret_val
}

execute_exist(){
    is_ok=true
    apps=""

    for e in $*;do
        which ${e} > /dev/null 2>&1
        if [ $? == 1 ];then
            apps="${apps} ${red}${e}${plain}"
            is_ok=false
        else
            apps="${apps} ${green}${e}${plain}"
        fi
    done


    if [ $is_ok != true ];then
        printf "Make sure you installed the following programs (red is not install): ${apps} \n"
        exit 1
    else
        return 0
    fi
}

get_config_names(){
    temp=$(ls)

    index=0
    for i in $temp;do
        if [[ ! "${CONF_IGNORE[@]}" =~ "${i}" ]];then
            CONF_NAMES[$index]=$i
            ((index++))
        fi
    done

}

install_config_file(){
    if [ -f ${1} ];then
        mkdir -p ${2}
        cp ${1} ${2}
    fi
}
install_config_dir(){
    if [ -d ${1} ];then
        mkdir -p ${2}
        cp ${1} ${2} -r
    fi
}

execute_install_script(){
    CONFIG_PATH="${REPOSITORY_PATH}/${1}"

    printf "${installing}:${1} configuration\n"
    source ./${1}/install.sh
    if [ $? == 0 ];then
        printf "${installed}:${1} configuration\n"
    else
        printf "${error}:install ${1} configuration failed\n"
    fi

    printf "\n"
}

main(){
    REPOSITORY_PATH=$(pwd)

    execute_exist wget git

    if [ ! -d "../${REPOSITORY_NAME}" ];then
        NEED_DELETE_REPOSITORY=true
        if [ ! -d "./${REPOSITORY_NAME}" ];then
            git clone ${REPOSITORY_URL}
        fi
        cd "${REPOSITORY_NAME}"
    fi

    get_config_names

    # hide the cursor
    printf "\e[?25l"

    # show the cursor while SIGINT
    trap 'printf "\e[?25h";exit 2' SIGINT

    while true
    do
        select_panel "Select configuration you want to install:" ${CONF_NAMES[*]}

        result=$?
        if [ "$result" == "0" ];then
            continue
        elif [ "$result" == "254" ];then
            break
        elif [ "$result" == "255" ];then
            for i in ${CONF_NAMES[*]};do
                execute_install_script $i
            done
        elif (( $result > 0 )) && (( $result <= ${#CONF_NAMES[*]} ));then
            execute_install_script ${CONF_NAMES[`expr $result-1`]}
        fi
    done

    delete_repository

    # show the cursor
    printf "\e[?25h"
}

main $@
