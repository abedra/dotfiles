#!/bin/bash

set -o nounset
set -o errexit

source $(pwd)/functions.sh

link_with_backup .gitconfig
link_with_backup .tmux.conf

replace_with_symlink config/alacritty $HOME/.config/alacritty
