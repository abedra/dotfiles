#!/usr/bin/env bash

set -o nounset
set -o errexit

source $(pwd)/functions.sh

setup_logging
detect_distro
install_packages

validate_requirements

install_omz
install_omz_plugins
create_required_directories

link_with_backup .gitconfig
link_with_backup .tmux.conf
link_with_backup .zshrc
link_with_backup .p10k.zsh

replace_with_symlink config/alacritty $HOME/.config/alacritty

footer