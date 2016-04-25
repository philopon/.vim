#!/usr/bin/env bash

# curl -L https://raw.githubusercontent.com/philopon/.vim/master/README.sh | bash

set -e

BRANCH=${BRANCH:-master}

mkdir -p ~/.config
NVIM_DIR=~/.config/nvim
[ ! -d $NVIM_DIR ] && git clone --branch $BRANCH git@github.com:philopon/.vim.git $NVIM_DIR

cd ~
ln -sf $NVIM_DIR/init.vim .vimrc
ln -sf $NVIM_DIR/gvimrc .gvimrc
