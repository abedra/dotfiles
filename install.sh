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

link_with_backup .gitconfig
link_with_backup .tmux.conf
link_with_backup .zshrc
link_with_backup .p10k.zsh

replace_with_symlink config/neofetch $HOME/.config/neofetch
create_localrc

if [ "$DESKTOP" == "true" ]; then
	echo "Installing desktop packages"
	install_packages desktop.list
	install_extra_packages desktop-extra.list
	replace_with_symlink config/alacritty $HOME/.config/alacritty
	mkdir $HOME/.themes
	replace_with_symlink config/themes/gnome/catppuccin $HOME/.themes/catpuccin
	cp -r config/themes/gnome/catppuccin/gtk-4.0/* $HOME/.config/gtk-4.0
fi

footer
