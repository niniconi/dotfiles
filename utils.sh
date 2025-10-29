#!/bin/bash
PKG_MGR=pacman
PKG_MGR_INSTALL=-S
pkg_install_command='pacman -S'

function parse_meta_file_get(){
    grep "^$2=" "$1" | sed "s/^$2=//g"
}

function pkg_selector(){
    local ident=0
    local install_pkgs=""

    for pkg in $1;
    do
        printf "$ident) $pkg " >&2
        ((ident++))
    done
    printf "\n" >&2
    read -p "input the you choose(defualt=all):" choose

    local len=`echo $choose | wc -w`
    if [[ $len == 0 ]]
    then
        install_pkgs=$1
    else
        pkgs=($1)
        for index in $choose
        do
            install_pkgs="$install_pkgs ${pkgs[$index]}"
        done
    fi
    echo $install_pkgs
    printf "\n"
}

# This script separates the logic for identifying the OS/distribution
# and determining the package manager command into distinct functions.

# Variable to store the system identifier (e.g., ubuntu, centos, macos)
# Variable to store the package manager command (e.g., apt, dnf, brew)

# --- Function to determine the operating system and distribution ---
get_system_identifier() {
    local SYSTEM_IDENTIFIER
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            SYSTEM_IDENTIFIER="$ID" # e.g., ubuntu, centos, fedora
        elif type lsb_release >/dev/null 2>&1; then
            # Fallback for Debian/Ubuntu and derivatives
            SYSTEM_IDENTIFIER="$(lsb_release -i | cut -f2 | tr '[:upper:]' '[:lower:]')" # Convert to lowercase
        elif [ -f /etc/redhat-release ]; then
            # Fallback for RHEL/CentOS/Fedora/Scientific Linux
            if grep -q "Red Hat" /etc/redhat-release; then
                SYSTEM_IDENTIFIER="redhat"
            elif grep -q "CentOS" /etc/redhat-release; then
                SYSTEM_IDENTIFIER="centos"
            elif grep -q "Fedora" /etc/redhat-release; then
                SYSTEM_IDENTIFIER="fedora"
            elif grep -q "Scientific Linux" /etc/redhat-release; then
                SYSTEM_IDENTIFIER="scientificlinux"
            else
                SYSTEM_IDENTIFIER="rhel_derivative"
            fi
        elif [ -f /etc/SuSE-release ]; then
            SYSTEM_IDENTIFIER="suse"
        elif [ -f /etc/arch-release ]; then
            SYSTEM_IDENTIFIER="archlinux"
        elif [ -f /etc/gentoo-release ]; then
            SYSTEM_IDENTIFIER="gentoo"
        elif [ -f /etc/alpine-release ]; then
            SYSTEM_IDENTIFIER="alpine"
        elif [ -f /etc/debian_version ]; then
            SYSTEM_IDENTIFIER="debian"
        else
            SYSTEM_IDENTIFIER="linux_unknown_distribution"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        SYSTEM_IDENTIFIER="macos"
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        SYSTEM_IDENTIFIER="cygwin"
    elif [[ "$OSTYPE" == "msys" ]]; then
        SYSTEM_IDENTIFIER="msys2"
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        SYSTEM_IDENTIFIER="freebsd"
    elif [[ "$OSTYPE" == "openbsd"* ]]; then
        SYSTEM_IDENTIFIER="openbsd"
    elif [[ "$OSTYPE" == "netbsd"* ]]; then
        SYSTEM_IDENTIFIER="netbsd"
    else
        SYSTEM_IDENTIFIER="unknown_os"
    fi
    echo "$SYSTEM_IDENTIFIER"
}

# --- Function to determine the package manager command based on SYSTEM_IDENTIFIER ---
get_package_manager() {
    local PACKAGE_MANAGER_CMD
    case "$1" in
        ubuntu|debian)
            PACKAGE_MANAGER_CMD="apt"
            ;;
        centos|rhel|fedora|rocky|almalinux|scientificlinux|rhel_derivative)
            # Prioritize dnf, fallback to yum for older systems
            if command -v dnf &> /dev/null; then
                PACKAGE_MANAGER_CMD="dnf"
            else
                PACKAGE_MANAGER_CMD="yum"
            fi
            ;;
        suse)
            PACKAGE_MANAGER_CMD="zypper"
            ;;
        archlinux|arch)
            PACKAGE_MANAGER_CMD="pacman"
            ;;
        gentoo)
            PACKAGE_MANAGER_CMD="emerge"
            ;;
        alpine)
            PACKAGE_MANAGER_CMD="apk"
            ;;
        macos)
            if command -v brew &> /dev/null; then
                PACKAGE_MANAGER_CMD="brew"
            else
                PACKAGE_MANAGER_CMD="macos_no_brew" # Homebrew not found
            fi
            ;;
        cygwin)
            if command -v apt-cyg &> /dev/null; then
                PACKAGE_MANAGER_CMD="apt-cyg"
            else
                PACKAGE_MANAGER_CMD="cygwin_setup_installer" # Suggest using setup.exe
            fi
            ;;
        msys2)
            PACKAGE_MANAGER_CMD="pacman"
            ;;
        freebsd)
            PACKAGE_MANAGER_CMD="pkg"
            ;;
        openbsd)
            PACKAGE_MANAGER_CMD="pkg_add"
            ;;
        netbsd)
            PACKAGE_MANAGER_CMD="pkgin"
            ;;
        *)
            PACKAGE_MANAGER_CMD="unknown_pm" # Catch-all for unrecognized systems or distributions
            ;;
    esac
    echo "$PACKAGE_MANAGER_CMD"
}

# Function: Checks the installation status of a package using a specified package manager.
# Usage: check_package_status <manager> <package_name>
# <manager> options: 'dpkg', 'rpm', 'pacman', 'apk'
# Returns: 0 (Installed) or 1 (Not Installed/Error)
check_package_status() {
    local manager="$1"     # Package manager type
    local package_name="$2" # Package name

    if [ -z "$manager" ] || [ -z "$package_name" ]; then
        echo "❌ Error: Please provide both manager type and package name." >&2
        echo "Usage: check_package_status <manager> <package_name>" >&2
        return 1
    fi

    # Convert manager name to lowercase for case-insensitive matching
    local lower_manager=$(echo "$manager" | tr '[:upper:]' '[:lower:]')

    case "$lower_manager" in

        # Debian/Ubuntu systems
        dpkg|apt)
            if command -v dpkg-query &> /dev/null; then
                # dpkg-query checks for 'install ok installed' status
                if dpkg-query -W -f='${Status}' "$package_name" 2>/dev/null | grep -q "install ok installed"; then
                    echo "✅ '$package_name' is installed (Manager: $manager)."
                    return 0
                fi
            fi
            ;;

        # Red Hat/Fedora/CentOS systems
        rpm|yum|dnf)
            if command -v rpm &> /dev/null; then
                # rpm -q returns 0 if package is found
                if rpm -q "$package_name" &> /dev/null; then
                    echo "✅ '$package_name' is installed (Manager: $manager)."
                    return 0
                fi
            fi
            ;;

        # Arch Linux/Manjaro systems
        pacman)
            if command -v pacman &> /dev/null; then
                # pacman -Q queries installed packages
                if pacman -Q "$package_name" &> /dev/null; then
                    echo "✅ '$package_name' is installed (Manager: $manager)."
                    return 0
                fi
            fi
            ;;

        # Alpine Linux systems
        apk)
            if command -v apk &> /dev/null; then
                # apk info -e checks for installed status
                if apk info -e "$package_name" &> /dev/null; then
                    echo "✅ '$package_name' is installed (Manager: $manager)."
                    return 0
                fi
            fi
            ;;

        *)
            echo "⚠️ Warning: Unsupported or unrecognized package manager type: '$manager'." >&2
            return 1
            ;;
    esac

    # If execution reaches this point, the package is not installed or command is missing
    echo "❌ Package '$package_name' is NOT installed (Manager: $manager)."
    return 1
}

function pkg_install(){
    if [[ -n "$1" ]]; then
        uninstalled_pkg=""
        for pkg in $(echo $@); do
            check_package_status $(get_package_manager `get_system_identifier`) $pkg
            check_status=$?
            if [[ $check_status != 0 ]];then
                uninstalled_pkg="$uninstalled_pkg $pkg"
            fi
        done
        if [[ -n "$uninstalled_pkg" ]];then 
            sudo $pkg_install_command $uninstalled_pkg
        fi
    else
        printf "❌ Error: pkg_install expected latest 1 param\n"
    fi
}

function pkg_install_unchecked(){
    sudo $pkg_install_command $1
}

