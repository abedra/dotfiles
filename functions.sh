cd $(dirname $0)
export DOTFILES=$(pwd)

RESET='\033[0;0m'
RED='\033[1;31m'
GREEN='\033[1;32m'

OMZ_DIR=$HOME/.oh-my-zsh
OMZ_PLUGINS_DIR=$OMZ_DIR/custom/plugins
OMZ_THEMES_DIR=$OMZ_DIR/custom/themes
CONFIG_DIR=$HOME/.config
LOG_FILE=$DOTFILES/install.log

function setup_logging {
    rm -f $LOG_FILE
}

function backup {
    local FILE=$1
    if [ -L $FILE ]; then
        rm $FILE
    elif [ -e $FILE ]; then
        mv $FILE $FILE.bak
    fi
}

function link_with_backup {
    local FILENAME=$1
    local SOURCE=$DOTFILES/$FILENAME
    local TARGET=$HOME/$FILENAME
    backup $TARGET
    ln -sf $SOURCE $TARGET
}

function replace_with_symlink {
    local SOURCE=$DOTFILES/$1
    local TARGET=$2 
    rm -rf $TARGET
    ln -sf $SOURCE $TARGET
}

function repeat {
    for i in $(seq 1 $2); do printf "%s" $1; done
}

function validate_installed {
    if [ $? -eq 0 ]; then
        printf "\t${GREEN}[INSTALLED]${RESET}\n"
    else
        printf "\t${RED}[FAILED]${RESET}\n"
    fi
}

function detect_distro {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$NAME
    else
        echo "Unable to detect OS Distro"
        exit 1
    fi
}

function install_yay {
    if [ ! -d "yay" ]; then
        sudo pacman -S --needed base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        cd ..
    fi
}

function install_packages {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        detect_distro
        printf "Installing packages for ${DISTRO}\t"
        if [ "$DISTRO" == "Ubuntu" ]; then
            printf "\t"
            sudo apt-get update -y >> $LOG_FILE 2>&1
            sudo xargs apt-get install < ubuntu/$1 -y >> $LOG_FILE 2>&1
        elif [ "$DISTRO" == "Arch Linux" ]; then
            sudo pacman -Sy --noconfirm >> $LOG_FILE 2>&1
            sudo pacman -S - < arch/$1 --noconfirm >> $LOG_FILE 2>&1
	    install_yay
        elif [ "$DISTRO" == "Rocky Linux" ]; then
            sudo dnf install -y $(<rocky/$1) >> $LOG_FILE 2>&1
        else
            printf "${RED}[FAILED]${RESET} - Unable to detect package manager\n"
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        printf "Installing packages for ${OSTYPE}\t"
        brew install $(<mac/packages.list) >> $LOG_FILE 2>&1
    fi
    
    printf "${GREEN}[INSTALLED]${RESET}\n"
}

function install_extra_packages {
    printf "Installing extra packages for ${DISTRO}\t"
    yay -S - < arch/$1 --noconfirm >> $LOG_FILE 2>&1
    printf "${GREEN}[INSTALLED]${RESET}\n"
}

function validate_requirements {
    required_commands=(git zsh curl)

    for requirement in ${required_commands[@]}; do
        printf "Checking for %s" ${requirement}
        if command -v ${requirement} &> /dev/null; then
            printf "\t\t\t${GREEN}[INSTALLED]${RESET}\n"
        else
            printf "\t\t\t${RED}[FAILED]${RESET}\n"
            echo "Install all required programs and try again"
            exit 1
        fi
    done
}

function install_omz {
    if [ ! -d "$OMZ_DIR" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended >> $LOG_FILE 2>&1
    fi
    printf "Oh My Zsh\t\t\t\t${GREEN}[INSTALLED]${RESET}\n"
}

function install_omz_plugins {
    printf "powerlevel10k\t\t\t"
    if [ ! -d "$OMZ_THEMES_DIR/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k >> $LOG_FILE 2>&1
    fi
    validate_installed
    printf "zsh-autosuggestions\t\t"
    if [ ! -d "$OMZ_PLUGINS_DIR/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions >> $LOG_FILE 2>&1
    fi
    validate_installed
    printf "zsh-syntax-highlighting\t\t"
    if [ ! -d "$OMZ_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting >> $LOG_FILE 2>&1
    fi
    validate_installed
}

function create_required_directories {
    if [ ! -d "$CONFIG_DIR" ]; then
        mkdir -p $CONFIG_DIR
    fi
}

function footer {
    repeat "-" 35
    printf "\nInstall complete. All logs have been saved to ${LOG_FILE}\n"
}
