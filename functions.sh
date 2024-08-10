cd $(dirname $0)
export DOTFILES=$(pwd)

RESET='\033[0;0m'
RED='\033[1;31m'
GREEN='\033[1;32m'

CONFIG_DIR=$HOME/.config
LOG_FILE=$DOTFILES/install.log
LOCALRC_FILE=$HOME/.localrc
NVIM_DIR=$HOME/.config/nvim
TMUX_DIR=$HOME/.tmux

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
    sudo pacman -S --noconfirm --needed base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
  fi
}

function install_starship {
  mkdir -p ~/.local/bin
  curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin
}

function install_packages {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    detect_distro
    printf "Installing packages for ${DISTRO}\t"
    if [ "$DISTRO" == "Ubuntu" ]; then
      printf "\t"
      sudo apt-get update -y >>$LOG_FILE 2>&1
      sudo xargs apt-get install -y <ubuntu/$1 >>$LOG_FILE 2>&1
      install_starship
    elif [ "$DISTRO" == "Arch Linux" ]; then
      sudo pacman -Sy --noconfirm >>$LOG_FILE 2>&1
      sudo pacman -S - --noconfirm <arch/$1 >>$LOG_FILE 2>&1
      install_yay
    elif [ "$DISTRO" == "Rocky Linux" ]; then
      sudo dnf install -y $(<rocky/$1) >>$LOG_FILE 2>&1
      install_starship
    else
      printf "${RED}[FAILED]${RESET} - Unable to detect package manager\n"
      exit 1
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    printf "Installing packages for ${OSTYPE}\t"
    brew install $(<mac/packages.list) >>$LOG_FILE 2>&1
  fi

  printf "${GREEN}[INSTALLED]${RESET}\n"
}

function install_extra_packages {
  printf "Installing extra packages for ${DISTRO}\t"
  yay -S - --noconfirm <arch/$1 >>$LOG_FILE 2>&1
  printf "${GREEN}[INSTALLED]${RESET}\n"
}

function validate_requirements {
  required_commands=(git zsh curl)

  for requirement in ${required_commands[@]}; do
    printf "Checking for %s" ${requirement}
    if command -v ${requirement} &>/dev/null; then
      printf "\t\t\t${GREEN}[INSTALLED]${RESET}\n"
    else
      printf "\t\t\t${RED}[FAILED]${RESET}\n"
      echo "Install all required programs and try again"
      exit 1
    fi
  done
}

function install_zsh_plugins {
  printf "zsh-autosuggestions\t\t"
  if [ ! -d "~.zsh/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions >>$LOG_FILE 2>&1
  fi
  validate_installed
  printf "zsh-syntax-highlighting\t\t"
  if [ ! -d "~.zsh/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting >>$LOG_FILE 2>&1
  fi
  validate_installed
}

function install_lazyvim {
  if [ ! -d "$NVIM_DIR" ]; then
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git
  fi
}

function nvim_cleanup {
  rm -rf ~/.local/share/nvim
  rm -rf ~/.local/state/nvim
  rm -rf ~/.cache/nvim
  rm -rf ~/.config/nvim
}

function install_tpm {
  if [ ! -d "$TMUX_DIR" ]; then
    mkdir -p $TMUX_DIR/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

function install_scm_breeze {
  if [ ! -d "$HOME/.scm_breeze" ]; then
    git clone https://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
    sh ~/.scm_breeze/install.sh
  fi
}

function create_localrc {
  touch $LOCALRC_FILE
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
