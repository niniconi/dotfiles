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
INSTALL_PATH="$HOME"

# get_config_names
CONF_NAMES=()
CONF_IGNORE=". .git README.md install.sh l18n dot_install.sh resolve.sh utils.sh utils require screenshot"

SELECT_INDEX=1

. ./utils.sh
. ./l18n

# delete_repository(){
    # if [ $NEED_DELETE_REPOSITORY == true ];then
    #     cd ..
    #     if [ -d "./${REPOSITORY_NAME}" ];then
    #         rm "./${REPOSITORY_NAME}" -rf
    #         printf "${removed}:./${REPOSITORY_NAME}\n"
    #     fi
    # fi
# }

function find_root_path(){
    current_path=`pwd`
    while [[ ! -e .git ]] && [[ `pwd` != '/' ]]
    do
        cd ..
    done
    if grep url .git/config | grep -w `sed 's/https:\/\///g;s/\.git$//g' <<< $REPOSITORY_URL` >> /dev/null; then
        pwd
        return 0
    fi
    return 255
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

function make_pair(){
    [[ $# != 2 ]] && exit -1
    return $[ $1 * 100000 + $2]
}

function unwarp_pair_first(){
    [[ $# != 1 ]] && exit -1
    return $[$1/100000]
}

function unwarp_pair_second(){
    [[ $# != 1 ]] && exit -1
    return $[$1%100000]
}

# render the select panel
# @parm info text
# @parm status of options, split by ` `
# @parm label of options, split by ` `
# @parm show help
function _render_panel(){
    local info_text=$1
    local options_status=($2)
    local labels=$3
    local selected_index=$4
    local select_id=0

    # show help text
    local final_text=""
    final_text="${final_text}\n"
    final_text="${final_text}j --- roll down\n"
    final_text="${final_text}k --- roll up\n"
    final_text="${final_text}q --- quit\n"
    final_text="${final_text}G --- jump to end option\n"
    final_text="${final_text}$info_text\n\n"

    # echo $options_status >&2
    # render options
    for text in $labels;do
        local option_text=""

        if [[ "${options_status[$select_id]}" == "1" ]];then
            option_text="$option_text✅"
        else
            option_text="$option_text❌"
        fi

        if [[ "$select_id" == "$selected_index" ]];then
            option_text="$option_text ${red}-> "
        fi

        option_text="${option_text} ${underline}${bold}${text}${plain}"

        final_text="${final_text}${option_text}\n"

        ((select_id++))
    done

    # `all` option
    local select_all_text=""
    (( $selected_index == $select_id )) && select_all_text="$select_all_text ${red}-> "
    select_all_text="${select_all_text}   (a)  ${underline}${bold}all${plain}"

    # `quit` option
    local quit_text=""
    (( $selected_index == $select_id+1 )) && quit_text="$quit_text ${red}-> "
    quit_text="${quit_text}   (q)  ${underline}${bold}quit${plain}"

    final_text="${final_text}${select_all_text}\n${quit_text}\n\n"
    printf "$final_text" >&2

    # accept input
    read -n1 input
    echo -e "\b " >&2

    local ret_val="0"
    if [[ $input != "" ]];then
        if [[ $input == "j" ]];then
            ((selected_index++))
        elif [[ $input == "k" ]];then
            ((selected_index--))
        elif [[ $input == "q" ]];then
            ret_val=254
        elif [[ $input == "G" ]];then
            ((selected_index=select_id+1))
        elif [[ $input == "a" ]];then
            ret_val=255
        fi

        if (( $selected_index > $select_id + 1 ));then
            # jmp to first line
            ((selected_index=0))
        elif (( $selected_index < 0 ));then
            # jmp to end line
            ((selected_index=select_id+1))
        fi
    else
        # switch selected option
        [[ $selected_index -lt ${#options_status[@]} ]] && if [[ "${options_status[$selected_index]}" == "1" ]];then
            options_status[$selected_index]=0
        else
            options_status[$selected_index]=1
        fi

        if (( $selected_index == $select_id ));then
            ret_val=255
        elif (( $selected_index == $select_id + 1 ));then
            ret_val=254
        fi
    fi
    [[ $ret_val -lt 128 ]] && ret_val=$selected_index
    echo "${options_status[@]}"
    return $ret_val
}

select_panel_multi(){
    local info_text=$1
    local options=${@:2:$[$# - 1]}
    local _status=""
    local selected_index=0
    local lines_count=0

    lines_count=$[ `echo $options | wc -w` + `echo $info_text | wc -l` + 10 ]

    # generate default options_status
    for option in $options
    do
        _status="$_status 0"
    done

    while [[ $selected_index -lt 128 ]];
    do
        _status=`_render_panel "$info_text" "$_status" "$options" $selected_index`
        selected_index=$?
        clear_screen $lines_count >&2
    done

    [[ $selected_index == 255 ]] && {
        local _status=""
        for option in $options
        do
            _status="$_status 1"
        done
    }
    echo $_status
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
    local un_ignore_configs=`ls -a`
    for config in $un_ignore_configs
    do
        [[ ! -d $config ]] && continue
        grep -w $config <<< "$CONF_IGNORE" >> /dev/null || printf "%s " $config
    done
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

    # execute_exist wget git

    # if [ ! -d "../${REPOSITORY_NAME}" ];then
    #     NEED_DELETE_REPOSITORY=true
    #     if [ ! -d "./${REPOSITORY_NAME}" ];then
    #         git clone ${REPOSITORY_URL}
    #     fi
    #     cd "${REPOSITORY_NAME}"
    # fi

    local configs=`get_config_names`

    if [[ -z "$1" ]]; then
        # hide the cursor
        printf "\e[?25l"

        # show the cursor while SIGINT
        trap 'printf "\e[?25h";exit 2' SIGINT

        local result=`select_panel_multi "Select configuration you want to install:" "$configs"`

        local enable_configs=""
        local offset=0
        local configs=($configs)
        for _enable in $result
        do
            [[ "$_enable" == "1" ]] && enable_configs="$enable_configs ${configs[$offset]}"
            ((offset++))
        done
    else
        local enable_configs="$@"
        local error_msg=""
        for config in $@;do
            grep -w $config <<< "$configs" >> /dev/null || error_msg="$error_msg❌ Error: Not found config $config.\n"
        done

        if [[ -n "$error_msg" ]];then
            echo -ne $error_msg
            exit 1;
        fi
    fi

    echo $enable_configs

    # find . -maxdepth 1 -mindepth 1 -type d | while IFS= read configuration;
    for configuration in $enable_configs
    do
        configuration=`echo $configuration | sed 's/^.\///g'`
        ignore_list=".meta"
        require_pkg=""
        suggest_pkg=""
        if [[ -e "$configuration/.meta" ]];then
            ignore_list="`parse_meta_file_get "$configuration/.meta" ignore` .meta"
            require_pkg=`parse_meta_file_get "$configuration/.meta" require`
            suggest_pkg=`parse_meta_file_get "$configuration/.meta" suggest`
        fi

        if [[ `echo $require_pkg | wc -w` != 0 ]];then
            pkg_install "$require_pkg"
        fi
        if [[ `echo $suggest_pkg | wc -w` != 0 ]];then
            filtered_suggest_pkg=`pkg_selector $suggest_pkg`
            pkg_install "$filtered_suggest_pkg"
        fi

        find $configuration -type f | while IFS= read config_file
        do
            config_file=`echo $config_file | sed "s/^$configuration\\///g"`
            src_path="$configuration/$config_file"
            dst_path="$INSTALL_PATH/`echo $config_file | sed 's/dot_/./g'`"

            found_match=false
            for prefix in $ignore_list;
            do
                # Remove leading slash from the prefix if it exists, for robust matching
                # This makes "a/path" match "/a/path" in the known path
                cleaned_prefix="${prefix#/}"

                if [[ "$config_file" == "$cleaned_prefix"* ]]; then
                    found_match=true
                    break
                fi
            done

            # skip ignore target
            if $found_match; then
                echo "ignore $config_file" >&2
                continue
            fi

            # copy file and create directory
            if [[ ! -e "`dirname "$dst_path"`" ]];
            then
                mkdir -p `dirname "$dst_path"`
                echo "mkdir `dirname "$dst_path"`" >&2
            fi
            cp "$src_path" "$dst_path"
            echo "copy \"$src_path\"->\"$dst_path\"" >&2
        done
    done

    # delete_repository

    # show the cursor
    printf "\e[?25h"
}

main $@
