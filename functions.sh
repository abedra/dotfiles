cd $(dirname $0)
export DOTFILES=$(pwd)

RESET='\033[0;0m'
RED='\033[1;31m'
GREEN='\033[1;32m'

OMZ_DIR=$HOME/.oh-my-zsh
OMZ_PLUGINS_DIR=$OMZ_DIR/custom/plugins
OMZ_THEMES_DIR=$OMZ_DIR/custom/themes

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
    for i in $(seq 1 $2); do echo -n "$1"; done
}

function validate_installed {
    if [ $? -eq 0 ]; then
        printf "\t${GREEN}[INSTALLED]${RESET}\n"
    else
        printf "\t${RED}[FAILED]${RESET}\n"
    fi
}

function validate_requirements {
    required_commands=(git zsh curl)

    for requirement in ${required_commands[@]}; do
        printf "Checking for %s" ${requirement}
        if command -v ${requirement} &> /dev/null; then
            printf "\t\t${GREEN}[INSTALLED]${RESET}\n"
        else
            printf "\t\t${RED}[FAILED]${RESET}\n"
            echo "Install all required programs and try again"
            exit 1
        fi
    done
}

function install_omz {
    if [ ! -d "$OMZ_DIR" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > install.log 2>&1
    fi
    echo -e "Oh My Zsh\t\t\t${GREEN}[INSTALLED]${RESET}"
}

function install_omz_plugins {
    printf "powerlevel10k\t\t"
    if [ ! -d "$OMZ_THEMES_DIR/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k > install.log 2>&1
    fi
    validate_installed
    printf "zsh-autosuggestions\t"
    if [ ! -d "$OMZ_PLUGINS_DIR/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions > install.log 2>&1
    fi
    validate_installed
    printf "zsh-syntax-highlighting\t"
    if [ ! -d "$OMZ_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting > install.log 2>&1
    fi
    validate_installed
}

function footer {
    repeat "-" 35
    echo -e "\nInstall complete. All logs have been saved to ${DOTFILES}/install.log"
}