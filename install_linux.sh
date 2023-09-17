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

function replace_with_symlink {
    local SOURCE=$DOTFILES/$1
    local TARGET=$2
    rm -rf $TARGET
    ln -sf $SOURCE $TARGET
}

link_with_backup .gitconfig
link_with_backup .tmux.conf

replace_with_symlink config/alacritty $HOME/.config/alacritty
