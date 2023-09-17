#!/bin/bash

set -o nounset
set -o errexit

source $(pwd)/functions.sh

validate_requirements

install_omz
install_omz_plugins

link_with_backup .gitconfig
link_with_backup .tmux.conf

replace_with_symlink config/alacritty $HOME/.config/alacritty

footer