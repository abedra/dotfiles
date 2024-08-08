#!/usr/bin/env bash

set -o nounset
set -o errexit

source $(pwd)/functions.sh

DESKTOP="false"

setup_logging
install_packages packages.list

validate_requirements

install_omz
install_omz_plugins
create_required_directories
install_lazyvim
install_tpm
install_scm_breeze

link_with_backup .gitconfig
link_with_backup .tmux.conf
link_with_backup .zshrc

replace_with_symlink config/starship.toml $HOME/.config/starship.toml
replace_with_symlink config/neofetch $HOME/.config/neofetch

create_localrc

if [ "$DESKTOP" == "true" ]; then
  echo "Installing desktop packages"
  install_packages desktop.list
  install_extra_packages desktop-extra.list
  replace_with_symlink config/wezterm $HOME/.config/wezterm
fi

footer
