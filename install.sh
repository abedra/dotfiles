#!/bin/bash

set -o nounset
set -o errexit

cd $(dirname $0)
export DOTFILES=$(pwd)

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

# git
link_with_backup .gitconfig

# zsh
link_with_backup .zsh
link_with_backup .zshrc
link_with_backup .tmux.conf
link_with_backup .gitconfig
